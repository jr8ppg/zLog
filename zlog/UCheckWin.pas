unit UCheckWin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UzLogConst, UzLogGlobal, UzLogQSO, UzLogForm;

type
  TCheckWin = class(TZLogForm)
    Panel1: TPanel;
    Button3: TButton;
    ListBox: TListBox;
    StayOnTop: TCheckBox;
    procedure Button3Click(Sender: TObject);
    procedure StayOnTopClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetFontSize(): Integer; override;
    procedure SetFontSize(v: Integer); override;
    procedure UpdateFontSize(v: Integer); override;
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

procedure TCheckWin.FormCreate(Sender: TObject);
begin
   Inherited;
   ListBox.Font.Name := dmZLogGlobal.Settings.FBaseFontName;
   ListCWandPh := False;
end;

procedure TCheckWin.FormShow(Sender: TObject);
begin
   Inherited;
   ResetListBox;
   Renew(Main.CurrentQSO);
end;

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

function TCheckWin.GetFontSize(): Integer;
begin
   Result := ListBox.Font.Size;
end;

procedure TCheckWin.SetFontSize(v: Integer);
begin
   Inherited;
   UpdateFontSize(v);
end;

procedure TCheckWin.UpdateFontSize(v: Integer);
begin
   ListBox.Font.Size := v;
   ResetListBox();
end;

end.
