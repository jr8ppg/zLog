unit UARRLDXMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UACAGMulti, StdCtrls, checklst, JLLabel, ExtCtrls, Grids,
  UzLogConst, UzLogGlobal, UzLogQSO, UMultipliers;

type
  TState = class
    StateName : string;
    StateAbbrev : string;
    AltAbbrev : string;
    Worked : array[b19..HiBand] of boolean;
    Index : integer;
    constructor Create;
    function Summary : string;
    function Summary2 : string;
    function SummaryARRL10 : string;
  end;

  TStateList = class
    List : TList;
    constructor Create;
    procedure LoadFromFile(filename : string);
    destructor Destroy; override;
  end;

type
  TARRLDXMulti = class(TACAGMulti)
    procedure FormCreate(Sender: TObject);
    procedure GoButtonClick2(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    function GetIsIncrementalSearchPresent(): Boolean; override;
  private
    { Private declarations }
    procedure GoForwardMatch(strCode: string);
  public
    { Public declarations }
    StateList : TStateList;
    function ExtractMulti(aQSO : TQSO) : string; override;
    procedure UpdateData; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    procedure CheckMulti(aQSO : TQSO); override;
    procedure Reset; override;
    function ValidMulti(aQSO : TQSO) : boolean; override;
  end;

function GetState(aQSO : TQSO; SL : TStateList) : TState;

implementation

uses Main;

{$R *.DFM}

function GetState(aQSO: TQSO; SL: TStateList): TState;
var
   i: integer;
   str: string;
   S: TState;
begin
   Result := nil;
   str := aQSO.NrRcvd;

   for i := 0 to SL.List.Count - 1 do begin
      S := TState(SL.List[i]);
      if pos(',' + str + ',', ',' + S.AltAbbrev + ',') > 0 then begin
         Result := S;
         exit;
      end;
   end;
end;

procedure TARRLDXMulti.Edit1Change(Sender: TObject);
begin
   if (checkIncremental.Checked = True) then begin
      GoForwardMatch(Edit1.Text);
   end;
end;

function TARRLDXMulti.ExtractMulti(aQSO: TQSO): string;
var
   str: string;
   S: TState;
begin
   S := GetState(aQSO, StateList);
   if S <> nil then begin
      str := S.StateAbbrev;
   end
   else begin
      str := '';
   end;

   Result := str;
end;

function TARRLDXMulti.ValidMulti(aQSO: TQSO): boolean;
begin
   if GetState(aQSO, StateList) <> nil then
      Result := True
   else
      Result := False;
end;

procedure TARRLDXMulti.Reset;
var
   i, j: integer;
   B: TBand;
   str: string;
begin
   if StateList.List.Count = 0 then
      exit;

   j := Grid.TopRow;
   Grid.RowCount := 0;
   Grid.RowCount := StateList.List.Count;
   for i := 0 to StateList.List.Count - 1 do begin
      for B := b19 to HiBand do begin
         TState(StateList.List[i]).Worked[B] := False;
      end;
      str := TState(StateList.List[i]).Summary;
      Grid.Cells[0, i] := str;
   end;

   Grid.TopRow := j;
end;

procedure TARRLDXMulti.CheckMulti(aQSO: TQSO);
var
   str: string;
   S: TState;
begin
   Edit1.Text := aQSO.NrRcvd;

   if aQSO.NrRcvd = '' then begin
      MainForm.WriteStatusLine('', False);
      Exit;
   end;

   S := GetState(aQSO, StateList);
   if S = nil then begin
      MainForm.WriteStatusLine(TMainForm_Invalid_number, False);
      exit;
   end;

   str := S.Summary2;
   if S.Worked[aQSO.Band] then
      Insert('Worked on this band. ', str, 27)
   else
      Insert('Needed on this band. ', str, 27);

   MainForm.WriteStatusLine(str, False);
end;

procedure TARRLDXMulti.AddNoUpdate(var aQSO: TQSO);
var
   S: TState;
begin
   aQSO.NewMulti1 := False;

   if aQSO.Dupe then
      exit;

   S := GetState(aQSO, StateList);
   if S <> nil then begin
      aQSO.Multi1 := S.StateAbbrev;
      if S.Worked[aQSO.Band] = False then begin
         S.Worked[aQSO.Band] := True;
         aQSO.NewMulti1 := True;
      end;
   end
   else begin
      aQSO.Multi1 := '';
      aQSO.Memo := 'INVALID EXCHANGE ' + aQSO.Memo;
   end;
end;

constructor TState.Create;
var
   B: TBand;
begin
   for B := b19 to HiBand do
      Worked[B] := False;

   StateName := '';
   StateAbbrev := '';
   AltAbbrev := '';
   Index := 0;
end;

function TState.Summary: string;
var
   temp: string;
   B: TBand;
begin
   temp := FillRight(StateName, 22) + FillRight(StateAbbrev, 4) + '  ';

   for B := b19 to b28 do begin
      if NotWARC(B) then
         if Worked[B] then
            temp := temp + '* '
         else
            temp := temp + '. ';
   end;

   Result := ' ' + temp;
end;

function TState.SummaryARRL10: string;
var
   temp: string;
   B: TBand;
begin
   temp := ' ' + FillRight(StateAbbrev, 7) + FillRight(StateName, 32);

   for B := b19 to b35 do begin
      if Worked[B] then
         temp := temp + '*  '
      else
         temp := temp + '.  ';
   end;

   Result := temp;
end;

function TState.Summary2: string;
var
   temp: string;
   B: TBand;
begin
   temp := FillRight(StateName, 22) + FillRight(StateAbbrev, 4);

   for B := b19 to b28 do begin
      if Worked[B] then
         temp := temp + ' ' + MHzString[B]
      else
         temp := temp + '';
   end;

   Result := temp;
end;

constructor TStateList.Create;
begin
   List := TList.Create;
end;

destructor TStateList.Destroy;
var
   i: integer;
begin
   for i := 0 to List.Count - 1 do begin
      if List[i] <> nil then
         TState(List[i]).Free;
   end;

   List.Free;
end;

procedure TStateList.LoadFromFile(filename: string);
var
   f: textfile;
   str: string;
   S: TState;
begin
   assign(f, filename);

   try
      Reset(f);
   except
      on EFOpenError do begin
         exit; { Alert that the file cannot be opened \\ }
      end;
   end;

   readln(f, str);
   while not(eof(f)) do begin
      readln(f, str);
      if pos('end of file', LowerCase(str)) > 0 then
         break;
      S := TState.Create;
      S.Index := List.Count;
      S.StateName := TrimRight(Copy(str, 1, 22));
      S.StateAbbrev := TrimLeft(TrimRight(Copy(str, 30, 25)));
      if not(eof(f)) then begin
         readln(f, str);
         str := TrimRight(str);
         str := TrimLeft(str);
         if not CharInSet(str[length(str)], ['a' .. 'z', 'A' .. 'Z', '0' .. '9']) then
            System.Delete(str, length(str), 1);
         S.AltAbbrev := str;
      end;
      List.Add(S);
   end;
end;

procedure TARRLDXMulti.FormCreate(Sender: TObject);
begin
   // inherited;
   StateList := TStateList.Create;
   StateList.LoadFromFile('ARDX.DAT');

   Reset;
end;

procedure TARRLDXMulti.FormDestroy(Sender: TObject);
begin
   inherited;
   StateList.Free();
end;

procedure TARRLDXMulti.UpdateData;
var
   i: integer;
   str: string;
   B: TBand;
begin
   B := Main.CurrentQSO.Band;
   if B = bUnknown then begin
      Exit;
   end;

   for i := 0 to StateList.List.Count - 1 do begin
      str := TState(StateList.List[i]).Summary;
      if TState(StateList.List[i]).Worked[B] = True then begin
         Grid.Cells[0, i] := '~' + str;
      end
      else begin
         Grid.Cells[0, i] := str;
      end;
   end;
end;

procedure TARRLDXMulti.GoButtonClick2(Sender: TObject);
begin
   GoForwardMatch(Edit1.Text);
end;

procedure TARRLDXMulti.GoForwardMatch(strCode: string);
var
   i: Integer;
   l: Integer;
begin
   l := Length(strCode);
   for i := 0 to StateList.List.Count - 1 do begin
      if (strCode = Copy(TState(StateList.List[i]).StateAbbrev, 1, l)) then begin
         Grid.TopRow := i;
         Break;
      end;
   end;
end;

function TARRLDXMulti.GetIsIncrementalSearchPresent(): Boolean;
begin
   Result := checkIncremental.Checked;
end;

end.
