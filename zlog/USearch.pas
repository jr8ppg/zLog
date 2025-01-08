unit USearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TformSearch = class(TForm)
    editCallsign: TEdit;
    labelSearchString: TLabel;
    buttonFindNext: TButton;
    buttonFindPrev: TButton;
    procedure buttonFindNextClick(Sender: TObject);
    procedure editCallsignChange(Sender: TObject);
    procedure buttonFindPrevClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private êÈåæ }
    function GetFontName(): string;
    procedure SetFontName(v: string);
    function GetFontSize(): Integer;
    procedure SetFontSize(v: Integer);
  public
    { Public êÈåæ }
    property FontName: string read GetFontName write SetFontName;
    property FontSize: Integer read GetFontSize write SetFontSize;
  end;

implementation

uses
  Main;

{$R *.dfm}

procedure TformSearch.FormCreate(Sender: TObject);
begin
//
end;

procedure TformSearch.FormShow(Sender: TObject);
var
   h: Integer;
   x: Integer;
begin
   h := editCallsign.Height;

   ClientHeight := h + 4 + 4;
   editCallsign.Top := 4;
   buttonFindNext.Height := h;
   buttonFindNext.Top := editCallsign.Top;
   buttonFindPrev.Height := h;
   buttonFindPrev.Top := editCallsign.Top;
   labelSearchString.Top := (ClientHeight - labelSearchString.Height) div 2;

   x := 6;
   labelSearchString.Left := x;
   x := x + labelSearchString.Width + 8;
   editCallsign.Left := x;
   x := x + editCallsign.Width + 8;
   buttonFindNext.Left := x;
   x := x + buttonFindNext.Width + 4;
   buttonFindPrev.Left := x;
   x := x + buttonFindPrev.Width + 4;
   ClientWidth := x;
end;

procedure TformSearch.FormHide(Sender: TObject);
begin
   MainForm.QsoFindEnd();
   MainForm.SetLastFocus();
end;

procedure TformSearch.FormKeyPress(Sender: TObject; var Key: Char);
begin
   case Key of
      Char(VK_ESCAPE): begin
         Key := #00;
         Hide();
      end;
   end;
end;

procedure TformSearch.buttonFindNextClick(Sender: TObject);
var
   S: string;
begin
   S := editCallsign.Text;
   if S = '' then begin
      Exit;
   end;

   buttonFindNext.Default := True;
   buttonFindPrev.Default := False;
   MainForm.QsoFindNext(S);
   editCallsign.SetFocus();
end;

procedure TformSearch.buttonFindPrevClick(Sender: TObject);
var
   S: string;
begin
   S := editCallsign.Text;
   if S = '' then begin
      Exit;
   end;

   buttonFindNext.Default := False;
   buttonFindPrev.Default := True;
   MainForm.QsoFindPrev(S);
   editCallsign.SetFocus();
end;

procedure TformSearch.editCallsignChange(Sender: TObject);
begin
   buttonFindNext.Default := True;
   buttonFindPrev.Default := False;
   MainForm.QsoFindInit();
end;

function TformSearch.GetFontName(): string;
begin
   Result := editCallsign.Font.Name;
end;

procedure TformSearch.SetFontName(v: string);
begin
   editCallsign.Font.Name := v;
end;

function TformSearch.GetFontSize(): Integer;
begin
   Result := Font.Size;
end;

procedure TformSearch.SetFontSize(v: Integer);
begin
   Font.Size := v;
   editCallsign.Font.Size := v;
end;

end.
