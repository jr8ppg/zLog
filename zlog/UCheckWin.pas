unit UCheckWin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TCheckWin = class(TForm)
    Panel1: TPanel;
    Button3: TButton;
    ListBox: TListBox;
    StayOnTop: TCheckBox;
    procedure Button3Click(Sender: TObject);
    procedure StayOnTopClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  protected
    FFontSize: Integer;
    function GetFontSize(): Integer; virtual;
    procedure SetFontSize(v: Integer); virtual;
  private
    { Private declarations }
  public
    { Public declarations }
    ListCWandPh : boolean;
    BandRow : array[b19..HiBand] of Integer;
    procedure ResetListBox;
    procedure Renew(aQSO : TQSO); virtual;
    property FontSize: Integer read GetFontSize write SetFontSize;
  end;

implementation

uses
  Main;

{$R *.DFM}

procedure TCheckWin.Button3Click(Sender: TObject);
begin
   Close;
end;

procedure TCheckWin.StayOnTopClick(Sender: TObject);
begin
   If StayOnTop.Checked then
      FormStyle := fsStayOnTop
   else
      FormStyle := fsNormal;
end;

procedure TCheckWin.ResetListBox;
var
   B: TBand;
   i: Integer;
   hh: Integer;
begin
   i := 0;
   for B := b19 to HiBand do begin
      if (MainForm.BandMenu.Items[ord(B)].Enabled) and (MainForm.BandMenu.Items[ord(B)].Visible) then begin
         BandRow[B] := i;
         inc(i);
      end
      else
         BandRow[B] := -1;
   end;

   hh := Abs(ListBox.Font.Height) + 2;
   if ListCWandPh then begin
      ClientHeight := (hh * 2) * (i) + Panel1.Height + 8;
   end
   else begin
      ClientHeight := hh * (i) + Panel1.Height + 8;
   end;

   ListBox.Items.Clear;
   if ListCWandPh then begin
      for B := b19 to HiBand do begin
         if BandRow[B] >= 0 then begin
            ListBox.Items.Add(FillRight(MHzString[B], 5) + ' CW');
            ListBox.Items.Add(FillRight(MHzString[B], 5) + ' Ph');
         end;
      end;
   end
   else begin
      for B := b19 to HiBand do begin
         if BandRow[B] >= 0 then
            ListBox.Items.Add(MHzString[B]);
      end;
   end;
end;

procedure TCheckWin.Renew(aQSO: TQSO);
begin
end;

procedure TCheckWin.FormShow(Sender: TObject);
begin
   MainForm.AddTaskbar(Handle);

   ResetListBox;
   Renew(Main.CurrentQSO);
end;

procedure TCheckWin.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.SetLastFocus();
   end;
end;

procedure TCheckWin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   MainForm.DelTaskbar(Handle);
end;

procedure TCheckWin.FormCreate(Sender: TObject);
begin
   ListBox.Font.Name := dmZLogGlobal.Settings.FBaseFontName;
   ListCWandPh := False;
end;

function TCheckWin.GetFontSize(): Integer;
begin
   Result := FFontSize;
end;

procedure TCheckWin.SetFontSize(v: Integer);
begin
   FFontSize := v;
   ListBox.Font.Size := v;
   ResetListBox();
end;

end.
