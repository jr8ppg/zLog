unit UACAGMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, Grids, UzLogConst, UzLogGlobal, UzLogQSO,
  JLLabel, UBasicMulti, checklst, Cologrid, UMultipliers;

type
  TACAGMulti = class(TBasicMulti)
    Panel1: TPanel;
    Button3: TButton;
    Panel: TPanel;
    Label1R9: TRotateLabel;
    Label3R5: TRotateLabel;
    Label7: TRotateLabel;
    Label14: TRotateLabel;
    Label21: TRotateLabel;
    Label28: TRotateLabel;
    Label50: TRotateLabel;
    Label144: TRotateLabel;
    Label430: TRotateLabel;
    Label1200: TRotateLabel;
    Label2400: TRotateLabel;
    Label5600: TRotateLabel;
    Edit1: TEdit;
    Label10g: TRotateLabel;
    Button1: TButton;
    Grid: TMgrid;
    StayOnTop: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure GoButtonClick2(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure GridSetting(ARow, Acol: Integer; var Fcolor: Integer;
      var Bold, Italic, underline: Boolean);
    procedure StayOnTopClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    LatestMultiAddition : integer; // Grid.TopRow
    CityList : TCityList;
    procedure UpdateData; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    procedure Add(var aQSO : TQSO); override; {NewMulti}
    function ValidMulti(aQSO : TQSO) : boolean; override;
    procedure Reset; override;
    procedure CheckMulti(aQSO : TQSO); override;
    function ExtractMulti(aQSO : TQSO) : string; override;
    procedure SetNumberEditFocus; override;
    { Public declarations }
  end;

implementation

uses
  Main;

{$R *.DFM}

procedure TACAGMulti.Add(var aQSO: TQSO);
begin
   inherited;
end;

procedure TACAGMulti.UpdateData;
var
   i: Integer;
   C: TCity;
begin
   for i := 0 to CityList.List.Count - 1 do begin
      C := TCity(CityList.List[i]);
      Grid.Cells[0, i] := C.Summary;
   end;

   Grid.TopRow := LatestMultiAddition;
end;

procedure TACAGMulti.CheckMulti(aQSO: TQSO);
var
   str: string;
   i: Integer;
   C: TCity;
begin
   inherited;

   str := aQSO.NrRcvd;
   if str = '' then begin
      Exit;
   end;

   if CharInSet(str[length(str)], ['H', 'P', 'L', 'M']) = True then begin
      System.Delete(str, length(str), 1);
   end;

   for i := 0 to CityList.List.Count - 1 do begin
      C := TCity(CityList.List[i]);
      if str = C.CityNumber then begin
         Grid.TopRow := i;
         str := C.Summary2;

         if C.Worked[aQSO.Band] then begin
            str := 'Worked on this band. ' + str;
         end
         else begin
            str := 'Needed on this band. ' + str;
         end;

         MainForm.WriteStatusLine(str, False);
         Exit;
      end;
   end;

   MainForm.WriteStatusLine('Invalid number', False);
end;

function TACAGMulti.ExtractMulti(aQSO: TQSO): string;
var
   str: string;
begin
   Result := '';
   str := aQSO.NrRcvd;
   if str = '' then begin
      Exit;
   end;

   if CharInSet(str[length(str)], ['0' .. '9']) = False then begin
      Delete(str, length(str), 1);
   end;

   Result := str;
end;

procedure TACAGMulti.AddNoUpdate(var aQSO: TQSO);
var
   str: string;
   C: TCity;
begin
   aQSO.NewMulti1 := False;
   str := aQSO.NrRcvd;
   Delete(str, length(str), 1);
   aQSO.Multi1 := str;

   if aQSO.Dupe then begin
      Exit;
   end;

   C := CityList.GetCity(str);
   if C <> nil then begin
      if C.Worked[aQSO.Band] = False then begin
         C.Worked[aQSO.Band] := True;
         aQSO.NewMulti1 := True;
      end;
      LatestMultiAddition := C.Index;
   end;
end;

procedure TACAGMulti.Reset;
var
   i, j: Integer;
   B: TBand;
   str: string;
begin
   if CityList.List.Count = 0 then begin
      Exit;
   end;

   j := Grid.TopRow;
   Grid.RowCount := 0;
   Grid.RowCount := CityList.List.Count;

   for i := 0 to CityList.List.Count - 1 do begin
      for B := b19 to HiBand do begin
         TCity(CityList.List[i]).Worked[B] := False;
      end;

      str := TCity(CityList.List[i]).Summary;
      str[30] := ' ';
      Grid.Cells[0, i] := str;
   end;

   Grid.TopRow := j;
end;

function TACAGMulti.ValidMulti(aQSO: TQSO): Boolean;
var
   str: string;
   C: TCity;
   i: Integer;
   boo: Boolean;
begin
   Result := False;
   str := aQSO.NrRcvd;
   if not(length(str) in [5 .. 7]) then begin
      Exit;
   end;

   if CharInSet(str[length(str)], ['P', 'L', 'M', 'H']) = False then begin
      Exit;
   end;

   Delete(str, length(str), 1);

   boo := False;
   for i := 0 to CityList.List.Count - 1 do begin
      C := TCity(CityList.List[i]);
      if str = C.CityNumber then begin
         boo := True;
         Break;
      end;
   end;

   Result := boo;
end;

procedure TACAGMulti.FormCreate(Sender: TObject);
begin
   LatestMultiAddition := 0;
   CityList := TCityList.Create;
   CityList.LoadFromFile('ACAG.DAT');

   if CityList.List.Count = 0 then begin
      Exit;
   end;

   Reset;
end;

procedure TACAGMulti.FormDestroy(Sender: TObject);
begin
   inherited;
   CityList.Free();
end;

procedure TACAGMulti.Button1Click(Sender: TObject);
begin
   Close;
end;

procedure TACAGMulti.GoButtonClick2(Sender: TObject);
var
   temp: string;
   i: Integer;
begin
   temp := Edit1.Text;
   for i := 0 to CityList.List.Count - 1 do begin
      if pos(temp, TCity(CityList.List[i]).CityNumber) = 1 then begin
         Grid.TopRow := i;
         Break;
      end;
   end;
end;

procedure TACAGMulti.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
   inherited;

   if Key = Chr($0D) then begin
      GoButtonClick2(Self);
      Key := #0;
   end;
end;

procedure TACAGMulti.FormShow(Sender: TObject);
begin
   inherited;
   LatestMultiAddition := 0;
   UpdateData;
end;

procedure TACAGMulti.GridSetting(ARow, Acol: Integer; var Fcolor: Integer; var Bold, Italic, underline: Boolean);
var
   B: TBand;
begin
   inherited;

   if ARow > CityList.List.Count - 1 then begin
      Exit;
   end;

   B := Main.CurrentQSO.Band;
   if TCity(CityList.List[ARow]).Worked[B] then begin
      Fcolor := clRed;
   end
   else begin
      Fcolor := clBlack;
   end;
end;

procedure TACAGMulti.StayOnTopClick(Sender: TObject);
begin
   if StayOnTop.Checked then begin
      FormStyle := fsStayOnTop;
   end
   else begin
      FormStyle := fsNormal;
   end;
end;

procedure TACAGMulti.SetNumberEditFocus;
begin
   SetNumberEditFocusJARL;
end;

end.
