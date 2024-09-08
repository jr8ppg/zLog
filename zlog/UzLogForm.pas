unit UzLogForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  UzLogConst;

type
  TZLogForm = class(TForm)
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private 宣言 }
    FFontSize: Integer;
    FOnChangeFontSize: TChangeFontSizeProc;
  protected
    function GetFontSize(): Integer; virtual;
    procedure SetFontSize(v: Integer); virtual;
    procedure UpdateFontSize(v: Integer); virtual; abstract;
  public
    { Public 宣言 }
    property FontSize: Integer read GetFontSize write SetFontSize;
    property OnChangeFontSize: TChangeFontSizeProc read FOnChangeFontSize write FOnChangeFontSize;
  end;

implementation

{$R *.dfm}

uses
  Main;

procedure TZLogForm.FormCreate(Sender: TObject);
begin
   FOnChangeFontSize := nil;
end;

procedure TZLogForm.FormShow(Sender: TObject);
begin
   MainForm.AddTaskbar(Handle);
end;

procedure TZLogForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   MainForm.DelTaskbar(Handle);
end;

procedure TZLogForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE: begin
         Key := 0;
         MainForm.SetLastFocus();
      end;
   end;
end;

procedure TZLogForm.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
   font_size: Integer;
begin
   // CTRL+UPでフォントサイズDOWN
   if GetAsyncKeyState(VK_CONTROL) < 0 then begin
      font_size := FontSize;
      Dec(font_size);
      if font_size < 6 then begin
         font_size := 6;
      end;
      FontSize := font_size;

      // さらにSHIFTキーを押していると他のWindowも変更する
      if GetAsyncKeyState(VK_SHIFT) < 0 then begin
         if Assigned(FOnChangeFontSize) then begin
            FOnChangeFontSize(Self, font_size);
         end;
      end;

      UpdateFontSize(font_size);

      Refresh();

      Handled := True;
   end;
end;

procedure TZLogForm.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
   font_size: Integer;
begin
   // CTRL+UPでフォントサイズUP
   if GetAsyncKeyState(VK_CONTROL) < 0 then begin
      font_size := FontSize;
      Inc(font_size);
      if font_size > 28 then begin
         font_size := 28;
      end;
      FontSize := font_size;

      // さらにSHIFTキーを押していると他のWindowも変更する
      if GetAsyncKeyState(VK_SHIFT) < 0 then begin
         if Assigned(FOnChangeFontSize) then begin
            FOnChangeFontSize(Self, font_size);
         end;
      end;

      UpdateFontSize(font_size);

      Refresh();

      Handled := True;
   end;
end;

function TZLogForm.GetFontSize(): Integer;
begin
   Result := FFontSize;
end;

procedure TZLogForm.SetFontSize(v: Integer);
begin
   FFontSize := v;
end;

end.
