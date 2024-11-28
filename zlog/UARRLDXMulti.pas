unit UARRLDXMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UACAGMulti, StdCtrls, checklst, JLLabel, ExtCtrls, Grids,
  UzLogConst, UzLogGlobal, UzLogQSO, UMultipliers;

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
    StateList: TStateList;
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
   LatestMultiAddition := 0;
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

      LatestMultiAddition := S.Index;
   end
   else begin
      aQSO.Multi1 := '';
      aQSO.Memo := 'INVALID EXCHANGE ' + aQSO.Memo;
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

   if checkJumpLatestMulti.Checked = True then begin
      Grid.TopRow := LatestMultiAddition;
   end;

   Grid.Refresh();
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
   if l = 0 then begin
      Grid.TopRow := LatestMultiAddition;
      Exit;
   end;

   for i := 0 to StateList.List.Count - 1 do begin
      if (strCode = Copy(TState(StateList.List[i]).StateAbbrev, 1, l)) then begin
         Grid.TopRow := i;
         LatestMultiAddition := i;
         Break;
      end;
   end;
end;

function TARRLDXMulti.GetIsIncrementalSearchPresent(): Boolean;
begin
   Result := checkIncremental.Checked;
end;

end.
