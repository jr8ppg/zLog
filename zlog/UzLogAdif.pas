unit UzLogAdif;

interface

uses
  System.SysUtils, System.Classes, System.StrUtils,
  System.DateUtils, Generics.Collections, Generics.Defaults;

type
  TAdifField = class(TObject)
    FName: string;
    FLength: Integer;
    FValue: string;
  public
    constructor Create(); overload;
    constructor Create(fieldname: string; fieldlen: Integer; fieldvalue: string); overload;
    destructor Destroy(); override;
    property Name: string read FName write FName;
    property Value: string read FValue write FValue;
  end;

  TAdifQso = class(TObject)
    FFields: TList<TAdifField>;
  private
    function GetValue(const Name: string): string;
    procedure SetValue(const Name: string; Value: string);
  public
    constructor Create();
    destructor Destroy(); override;
    class function ParseAdifField(SRC: string; Index: Integer; var fieldname: string; var fieldlen: Integer; var fieldvalue: string): Integer;
    class function Parse(S: string): TAdifQso;
    property Fields: TList<TAdifField> read FFields;
    property Values[const Name: string]: string read GetValue write SetValue;
  end;

  TAdifFile = class(TObject)
    FFile: TStringList;
    FItems: TList<TAdifQso>;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure LoadFromFile(filename: string);
    procedure Parse();
    property Items: TList<TAdifQso> read FItems;
  end;

implementation

{ TAdifField }

constructor TAdifField.Create();
begin
   Inherited;
   FName := '';
   FLength := 0;
   FValue := '';
end;

constructor TAdifField.Create(fieldname: string; fieldlen: Integer; fieldvalue: string);
begin
   Inherited Create();
   FName := fieldname;
   FLength := fieldlen;
   FValue := fieldvalue;
end;

destructor TAdifField.Destroy();
begin
   Inherited;
end;

{ TAdifQso }

constructor TAdifQso.Create();
begin
   Inherited;
   FFields := TList<TAdifField>.Create();
end;

destructor TAdifQso.Destroy();
var
   O: TAdifField;
begin
   Inherited;
   for O in FFields do begin
      O.Free();
   end;
   FFields.Free();
end;

class function TAdifQso.Parse(S: string): TAdifQso;
var
   QSO: TAdifQso;
   fieldname: string;
   fieldlen: Integer;
   fieldvalue: string;
   position: Integer;
   field: TAdifField;
begin
   QSO := TAdifQso.Create();

   position := 1;
   while True do begin
      position := ParseAdifField(S, position, fieldname, fieldlen, fieldvalue);
      if position = 0 then begin
         Break;
      end;
      if UpperCase(fieldname) = 'EOR' then begin
         Break;
      end;

      field := TAdifField.Create(fieldname, fieldlen, fieldvalue);
      QSO.Fields.Add(field);
   end;

   Result := QSO;
end;

// <fieldname:len>fieldvalue
// 1234567890123       1  6  8
// <call:6>value
class function TAdifQso.ParseAdifField(SRC: string; Index: Integer; var fieldname: string; var fieldlen: Integer; var fieldvalue: string): Integer;
var
   I1, I2, I3: Integer;
   S: string;
begin
   I1 := Pos('<', SRC, Index);
   I2 := Pos(':', SRC, Index);
   I3 := Pos('>', SRC, Index);

   if (I1 = 0) or (I3 = 0) then begin
      Result := 0;
      Exit;
   end;

   if I2 = 0 then begin
      fieldname := UpperCase(Copy(SRC, I1 + 1, I3 - I1 - 1));
      fieldlen := 0;
      fieldvalue := '';
   end
   else begin
      fieldname := UpperCase(Copy(SRC, I1 + 1, I2 - I1 - 1));

      S := Copy(SRC, I2 + 1, I3 - I2 - 1);
      fieldlen := StrToIntDef(S, 0);

      fieldvalue := Copy(SRC, I3 + 1, fieldlen);
   end;

   // NEXT POSITION
   Result := I3 + fieldlen + 1;
end;

function TAdifQso.GetValue(const Name: string): string;
var
   i: Integer;
begin
   for i := 0 to FFields.Count - 1 do begin
      if FFields[i].Name = Name then begin
         Result := FFields[i].Value;
         Exit;
      end;
   end;
   Result := '';
end;

procedure TAdifQso.SetValue(const Name: string; Value: string);
var
   i: Integer;
   O: TAdifField;
begin
   for i := 0 to FFields.Count - 1 do begin
      if FFields[i].Name = Name then begin
         FFields[i].Value := Value;
         Exit;
      end;
   end;

   O := TAdifField.Create(Name, Length(Value), Value);
   FFields.Add(O);
end;

{ TAdifFile }

constructor TAdifFile.Create();
begin
   Inherited;
   FItems := TList<TAdifQso>.Create();
   FFile := TStringList.Create();
end;

destructor TAdifFile.Destroy();
var
   O: TAdifQso;
begin
   Inherited;
   for O in FItems do begin
      O.Free();
   end;
   FItems.Free();
   FFile.Free();
end;

procedure TAdifFile.LoadFromFile(filename: string);
begin
   FFile.LoadFromFile(filename);
end;

procedure TAdifFile.Parse();
var
   i: Integer;
   QSO: TAdifQso;
   S: string;
   fBody: Boolean;
begin
   fBody := False;
   for i := 0 to FFile.Count - 1 do begin
      S := FFile.Strings[i];
      if UpperCase(S) = '<EOH>' then begin
         fBody := True;
         Continue;
      end;
      if fBody = False then begin
         Continue;
      end;

      QSO := TAdifQso.Parse(S);
      FItems.Add(QSO);
   end;
end;

end.
