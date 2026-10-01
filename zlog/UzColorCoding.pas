unit UzColorCoding;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  Generics.Collections, Generics.Defaults;

type
  TColorCoding = class(TObject)
    FKeyword: string;
    FForeColor: TColor;
    FBackColor: TColor;
    FBold: Boolean;
    FItalic: Boolean;
  private
    function GetText(): string;
    procedure SetText(S: string);
  public
    constructor Create();
    property Keyword: string read FKeyword write FKeyword;
    property ForeColor: TColor read FForeColor write FForeColor;
    property BackColor: TColor read FBackColor write FBackColor;
    property Bold: Boolean read FBold write FBold;
    property Italic: Boolean read FItalic write FItalic;
    property Text: string read GetText write SetText;
  end;

  TColorCodingList = class(TObjectList<TColorCoding>)
  public
    constructor Create(OwnsObjects: Boolean = True);
    destructor Destroy(); override;
    function ObjectOf(C: string): TColorCoding;
  end;

implementation

uses
  UzLogGlobal;

{ TColorCoding }

constructor TColorCoding.Create();
begin
   FKeyword := '';
   FForeColor := clBlack;
   FBackColor := clWhite;
   FBold := False;
   FItalic := False;
end;

function TColorCoding.GetText(): string;
var
   SL: TStringList;
begin
   SL := TStringList.Create();
   try
      SL.Add(FKeyword);
      SL.Add(ZColorToString(FForeColor));
      SL.Add(ZColorToString(FBackColor));
      SL.Add(BoolToStr(FBold));
      SL.Add(BoolToStr(FItalic));
   finally
      Result := SL.CommaText;
      SL.Free();
   end;
end;

procedure TColorCoding.SetText(S: string);
var
   SL: TStringList;
begin
   SL := TStringList.Create();
   try
      SL.CommaText := S + ',,,,,';
      FKeyword := SL[0];
      FForeColor := ZStringToColorDef(SL[1], clBlack);
      FBackColor := ZStringToColorDef(SL[2], clWhite);
      FBold := StrToBoolDef(SL[3], False);
      FItalic := StrToBoolDef(SL[4], False);
   finally
      SL.Free();
   end;
end;

{ TColorCodingList }

constructor TColorCodingList.Create(OwnsObjects: Boolean);
begin
   Inherited Create(OwnsObjects);
end;

destructor TColorCodingList.Destroy();
begin
   Inherited;
end;

function TColorCodingList.ObjectOf(C: string): TColorCoding;
var
   i: Integer;
begin
   for i := 0 to Count - 1 do begin
      if Items[i].Keyword = C then begin
         Result := Items[i];
         Exit;
      end;
   end;

   Result := nil;
end;

end.
