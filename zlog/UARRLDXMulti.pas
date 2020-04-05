unit UARRLDXMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UACAGMulti, StdCtrls, checklst, JLLabel, ExtCtrls, Grids,
  Cologrid, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TState = class
    StateName : string[23];
    StateAbbrev : string[3];
    AltAbbrev : string[80];
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
    procedure GridSetting(ARow, Acol: Integer; var Fcolor: Integer;
      var Bold, Italic, underline: Boolean);
    procedure GoButtonClick2(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    StateList : TStateList;
    function ExtractMulti(aQSO : TQSO) : string; override;
    procedure Update; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    procedure CheckMulti(aQSO : TQSO); override;
    procedure Reset; override;
    function ValidMulti(aQSO : TQSO) : boolean; override;
  end;

function GetState(aQSO : TQSO; SL : TStateList) : TState;

implementation

uses Main;

{$R *.DFM}

function GetState(aQSO : TQSO; SL : TStateList) : TState;
var i : integer;
    str : string;
    S : TState;
begin
  Result := nil;
  str := aQSO.NrRcvd;
  for i := 0 to SL.List.Count-1 do
    begin
      S := TState(SL.List[i]);
      if pos(','+str+',', ','+S.AltAbbrev+',') > 0 then
        begin
          Result := S;
          exit;
        end;
    end;
end;

function TARRLDXMulti.ExtractMulti(aQSO : TQSO) : string;
var str : string;
    S : TState;
begin
  S := GetState(aQSO, StateList);
  if S <> nil then
    begin
      str := S.StateAbbrev;
    end
  else
    begin
      str := '';
    end;
  Result := str;
end;

function TARRLDXMulti.ValidMulti(aQSO : TQSO) : boolean;
begin
  if GetState(aQSO, StateList) <> nil then
    Result := True
  else
    Result := False;
end;

procedure TARRLDXMulti.Reset;
var i, j : integer;
    B : TBand;
    str : string;
begin
  if StateList.List.Count = 0 then exit;
  j := Grid.TopRow;
  Grid.RowCount := 0;
  Grid.RowCount := StateList.List.Count;
  for i := 0 to StateList.List.Count-1 do
    begin
      for B := b19 to HiBand do
        TState(StateList.List[i]).Worked[B] := false;
      str := TState(StateList.List[i]).Summary;
      Grid.Cells[0,i] := str;
    end;
  Grid.TopRow := j;
end;

procedure TARRLDXMulti.CheckMulti(aQSO : TQSO);
var str : string;
    i : integer;
    S : TState;
begin
  S := GetState(aQSO, StateList);
  if S = nil then
    begin
      MainForm.WriteStatusLine('Invalid number', false);
      exit;
    end;
  str := S.Summary2;
  if S.Worked[aQSO.Band] then
    Insert('Worked on this band. ',str, 27)
  else
    Insert('Needed on this band. ',str, 27);
  MainForm.WriteStatusLine(str, false);
end;

procedure TARRLDXMulti.AddNoUpdate(var aQSO : TQSO);
var str : string;
    B : TBand;
    j : integer;
    S : TState;
begin
  aQSO.NewMulti1 := False;

  if aQSO.Dupe then
    exit;

  S := GetState(aQSO, StateList);
  if S <> nil then
    begin
      aQSO.Multi1 := S.StateAbbrev;
      if S.Worked[aQSO.Band] = false then
        begin
          S.Worked[aQSO.band] := True;
          aQSO.NewMulti1 := True;
        end;
    end
  else
    begin
      aQSO.Multi1 := '';
      aQSO.Memo := 'INVALID EXCHANGE '+aQSO.Memo;
    end;
end;

constructor TState.Create;
var B : TBand;
begin
  for B := b19 to HiBand do
    Worked[B] := False;
  StateName := '';
  StateAbbrev := '';
  AltAbbrev := '';
  Index := 0;
end;

function TState.Summary : string;
var temp : string;
    B : TBand;
begin
  temp := '';
  temp := FillRight(StateName,22)+FillRight(StateAbbrev,4)+'  ';
  for B := b19 to b28 do
    if NotWARC(B) then
      if Worked[B] then
        temp := temp + '* '
      else
        temp := temp + '. ';
  Result := ' ' + temp;
end;

function TState.SummaryARRL10 : string;
var temp : string;
    B : TBand;
begin
  temp := ' '+FillRight(StateAbbrev,7)+FillRight(StateName,32);
  for B := b19 to b35 do
   if Worked[B] then
     temp := temp + '*  '
   else
     temp := temp + '.  ';
  Result := temp;
end;

function TState.Summary2 : string;
var temp : string;
    B : TBand;
begin
  temp := '';
  temp := FillRight(StateName,22)+FillRight(StateAbbrev,4);
  for B := b19 to b28 do
    if Worked[B] then
      temp := temp + ' '+MHzString[B]
    else
      temp := temp + '';
  Result := temp;
end;

constructor TStateList.Create;
begin
  List := TList.Create;
end;

destructor TStateList.Destroy;
var i : integer;
begin
  for i := 0 to List.Count - 1 do
    begin
      if List[i] <> nil then
        TState(List[i]).Free;
    end;
  List.Free;
end;

procedure TStateList.LoadFromFile(filename : string);
var f : textfile;
    str : string;
    S : TState;
begin
  assign(f, filename);
  try
    reset(f);
  except
    on EFOpenError do
      begin
        exit;    {Alert that the file cannot be opened \\}
      end;
  end;
  readln(f, str);
  while not(eof(f)) do
    begin
      readln(f, str);
      if Pos('end of file', LowerCase(str))>0 then break;
      S := TState.Create;
      S.Index := List.Count;
      S.StateName := TrimRight(Copy(str, 1, 22));
      S.StateAbbrev := TrimLeft(TrimRight(Copy(str, 30, 25)));
      if not(eof(f)) then
        begin
          readln(f, str);
          str := TrimRight(str);
          str := TrimLeft(str);
          if not(str[length(str)] in ['a'..'z','A'..'Z','0'..'9']) then
            System.Delete(str,length(str),1);
          S.AltAbbrev := str;
        end;
      List.Add(S);
    end;
end;



procedure TARRLDXMulti.FormCreate(Sender: TObject);
begin
  //inherited;
  StateList := TStateList.Create;
  StateList.LoadFromFile('ARDX.DAT');
  Reset;
end;

procedure TARRLDXMulti.Update;
var i : integer;
    str : string;
begin
  for i := 0 to StateList.List.Count-1 do
    begin
      str := TState(StateList.List[i]).Summary;
      Grid.Cells[0,i] := str;
    end;
end;


procedure TARRLDXMulti.GridSetting(ARow, Acol: Integer;
  var Fcolor: Integer; var Bold, Italic, underline: Boolean);
var B : TBand;
begin
  //inherited;
  B := Main.CurrentQSO.Band;
  if TState(StateList.List[ARow]).Worked[B] then
    FColor := clRed
  else
    FColor := clBlack;
end;

procedure TARRLDXMulti.GoButtonClick2(Sender: TObject);
var i : integer;
    str : string;
begin
  if StateList.List.Count = 0 then exit;
  for i := 0 to StateList.List.Count-1 do
    begin
      str := TState(StateList.List[i]).Summary;
      if pos(Edit1.Text,str)=1 then
        begin
          Grid.TopRow := i;
          exit;
        end;
    end;
end;

end.
