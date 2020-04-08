unit USuperCheck;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Spin, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TSuperData = class
    callsign : string;
    number : string;
    function Summary : string;
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
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ListBoxDblClick(Sender: TObject);
    procedure StayOnTopClick(Sender: TObject);
    procedure SpinEditChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    //SuperCheckList : TStringList;
    SuperCheckList2 : TList;
    TwoLetterMatrix : array[0..255, 0..255] of TList; // 2.1f
    { Private declarations }
  public
    HitCall : string;
    HitNumber : integer;
    FirstDataCall, Rcvd_Estimate : string;
    procedure CheckSuper(aQSO : TQSO);
    { Public declarations }
  end;

var
  SuperCheck: TSuperCheck;

implementation

uses Main, UOptions;

{$R *.DFM}

function TSuperData.Summary: string;
begin
   Result := FillRight(callsign, 11) + number;
end;

procedure TSuperCheck.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

function PartialMatch(A, B: string): boolean;
var
   i: integer;
begin
   Result := False;
   if (Pos('.', A) = 0) { and (Pos('?',A)=0) } then
      Result := (Pos(A, B) > 0)
   else begin
      if length(A) > length(B) then
         exit;

      for i := 1 to length(A) do
         if A[i] <> '.' then
            if A[i] <> B[i] then
               exit;

      Result := True;
   end;
end;

procedure TSuperCheck.CheckSuper(aQSO: TQSO);
var
   PartialStr: string;
   i: integer;
   maxhit, hit: integer;
   sd, FirstData: TSuperData;
   L: TList;
begin
   HitNumber := 0;
   HitCall := '';
   ListBox.Items.Clear;
   PartialStr := aQSO.callsign;
   FirstData := nil;

   if dmZlogGlobal.Settings._searchafter >= length(PartialStr) then
      exit;

   if Pos(',', PartialStr) = 1 then
      exit;

   maxhit := dmZlogGlobal.Settings._maxsuperhit;

   if PartialStr <> '' then begin
      ListBox.Enabled := False;
      hit := 0;

      if (length(PartialStr) >= 2) and (Pos('.', PartialStr) = 0) then
         L := TwoLetterMatrix[Ord(PartialStr[1]), Ord(PartialStr[2])]
      else
         L := SuperCheckList2;

      for i := 0 to L.Count - 1 do begin
         sd := TSuperData(L[i]);
         if ListBox.Items.Count = 0 then
            FirstData := sd;

         if PartialMatch(PartialStr, sd.callsign) then begin
            if hit = 0 then
               HitCall := sd.callsign;
            ListBox.Items.Add(sd.Summary);
            inc(hit);
            if hit >= maxhit then
               break;
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
end;

procedure TSuperCheck.Button3Click(Sender: TObject);
begin
   Close;
end;

procedure TSuperCheck.FormCreate(Sender: TObject);
var
   f: textfile;
   str: string;
   i, j, x, y: integer;
   sd: TSuperData;
   filename: string;
begin
   SuperCheckList2 := TList.Create;

   Rcvd_Estimate := '';
   FirstDataCall := '';

   for i := 0 to 255 do begin // 2.1f
      for j := 0 to 255 do begin
         TwoLetterMatrix[i, j] := TList.Create;
      end;
   end;

   filename := ExtractFilePath(Application.EXEName) + 'ZLOG.SPC';
   if FileExists(filename) = False then begin
      exit;
   end;

   AssignFile(f, filename);
   Reset(f);
   while not(EOF(f)) do begin
      ReadLn(f, str);
      if str = '' then begin
         Continue;
      end;

      if str[1] = ';' then begin
         Continue;
      end;

      i := Pos(' ', str);
      sd := TSuperData.Create;
      if i = 0 then begin
         sd.callsign := str;
         sd.number := '';
      end
      else begin
         sd.callsign := copy(str, 1, i - 1);
         sd.number := TrimLeft(copy(str, i, 30));
      end;
      SuperCheckList2.Add(sd);

      for i := 1 to length(sd.callsign) - 1 do begin
         x := Ord(sd.callsign[i]);
         y := Ord(sd.callsign[i + 1]);
         if TwoLetterMatrix[x, y].Count > 0 then begin
            if TSuperData(TwoLetterMatrix[x, y].Last).callsign <> sd.callsign then begin
               TwoLetterMatrix[x, y].Add(sd);
            end;
         end
         else begin
            TwoLetterMatrix[x, y].Add(sd);
         end;
      end;
   end;

   CloseFile(f);
end;

procedure TSuperCheck.FormDestroy(Sender: TObject);
var
   i, j: integer;
begin
   SuperCheckList2.Free();
   for i := 0 to 255 do begin // 2.1f
      for j := 0 to 255 do begin
         TwoLetterMatrix[i, j].Free();
      end;
   end;
end;

procedure TSuperCheck.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.LastFocus.SetFocus;
   end;
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

end.
