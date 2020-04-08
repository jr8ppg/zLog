unit UFreqList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UCheckWin, StdCtrls, ExtCtrls, UzLogConst, UzLogGlobal;

type
  TFreqList = class(TCheckWin)
    ClearBtn: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
  private
    { Private declarations }
    FreqArray : array[0..30] of string;
    //function GetTXNr(S : string) : integer;
    function GetPCName(S : string) : string;
  public
    procedure UpdateData;
    procedure ProcessFreqData(S : string);
    { Public declarations }
  end;

var
  FreqList: TFreqList;

implementation

{$R *.DFM}

procedure TFreqList.UpdateData;
var
   B: integer;
   S: string;
begin
   ListBox.Items.Clear;
   for B := 0 to 30 do begin
      if FreqArray[B] <> '' then begin
         S := FreqArray[B];
         Delete(S, 1, 3);
         ListBox.Items.Add(S);
      end;
   end;
end;

function TFreqList.GetPCName(S: string): string;
var
   ss: string;
   i, j: integer;
begin
   ss := '';
   i := pos('[', S);
   j := pos(']', S);
   if (i > 0) and (j > 0) and (j > i) then begin
      ss := S;
      Delete(ss, 1, i);
      j := pos(']', ss);
      ss := copy(ss, 1, j - 1);
   end;
   Result := ss;
end;

procedure TFreqList.ProcessFreqData(S: string);
var
   ss: string;
   pcname: string;
   B: integer;
begin
   if length(S) < 30 then
      exit;

   // tx := GetTXNr(S);
   pcname := GetPCName(S);
   // label1.caption := pcname+'*';

   for B := 0 to 30 do
      if FreqArray[B] <> '' then
         if pcname = GetPCName(FreqArray[B]) { GetTXNr(FreqArray[B]) = tx } then
            FreqArray[B] := '';

   ss := copy(S, 1, 2);
   ss := TrimRight(ss);
   B := StrToInt(ss);
   if B <= ord(HiBand) then
      FreqArray[B] := S
   else // substation
   begin
      for B := ord(HiBand) + 1 to 30 do
         if FreqArray[B] = '' then begin
            FreqArray[B] := S;
            break;
         end;
   end;

   UpdateData;
end;

procedure TFreqList.FormShow(Sender: TObject);
begin
   // inherited;
   UpdateData;
end;

procedure TFreqList.FormCreate(Sender: TObject);
var
   B: integer;
begin
   for B := 0 to 30 do
      FreqArray[B] := '';
end;

procedure TFreqList.ClearBtnClick(Sender: TObject);
var
   B: integer;
begin
   // inherited;
   for B := 0 to 30 do
      FreqArray[B] := '';

   UpdateData;
end;

end.
