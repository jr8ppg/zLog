unit UQSOListColumnSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TformQSOListColumnSettings = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Edit3: TEdit;
    UpDown3: TUpDown;
    Edit4: TEdit;
    UpDown4: TUpDown;
    Edit5: TEdit;
    UpDown5: TUpDown;
    Edit6: TEdit;
    UpDown6: TUpDown;
    Edit7: TEdit;
    UpDown7: TUpDown;
    Edit8: TEdit;
    UpDown8: TUpDown;
    Edit11: TEdit;
    UpDown11: TUpDown;
    Edit12: TEdit;
    UpDown12: TUpDown;
    Edit13: TEdit;
    UpDown13: TUpDown;
    Edit14: TEdit;
    UpDown14: TUpDown;
    Edit15: TEdit;
    UpDown15: TUpDown;
    Edit9: TEdit;
    UpDown9: TUpDown;
    Edit10: TEdit;
    UpDown10: TUpDown;
    Edit16: TEdit;
    UpDown16: TUpDown;
    Edit17: TEdit;
    UpDown17: TUpDown;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private êÈåæ }
    FColCheckboxes: array[0..16] of TCheckBox;
    FColWidths: array[0..16] of TUpDown;
    function GetColumnWidths(Index: Integer): Integer;
    procedure SetColumnWidths(Index: Integer; v: Integer);
    function GetColumnVisible(Index: Integer): Boolean;
    procedure SetColumnVisible(Index: Integer; v: Boolean);
  public
    { Public êÈåæ }
    property ColumnVisible[Index: Integer]: Boolean read GetColumnVisible write SetColumnVisible;
    property ColumnWidths[Index: Integer]: Integer read GetColumnWidths write SetColumnWidths;
  end;

implementation

{$R *.dfm}

procedure TformQSOListColumnSettings.FormCreate(Sender: TObject);
begin
   FColCheckboxes[0] := CheckBox1;
   FColCheckboxes[1] := CheckBox2;
   FColCheckboxes[2] := CheckBox3;
   FColCheckboxes[3] := CheckBox4;
   FColCheckboxes[4] := CheckBox5;
   FColCheckboxes[5] := CheckBox6;
   FColCheckboxes[6] := CheckBox7;
   FColCheckboxes[7] := CheckBox8;
   FColCheckboxes[8] := CheckBox9;
   FColCheckboxes[9] := CheckBox10;
   FColCheckboxes[10] := CheckBox11;
   FColCheckboxes[11] := CheckBox12;
   FColCheckboxes[12] := CheckBox13;
   FColCheckboxes[13] := CheckBox14;
   FColCheckboxes[14] := CheckBox15;
   FColCheckboxes[15] := CheckBox16;
   FColCheckboxes[16] := CheckBox17;
   FColWidths[0] := UpDown1;
   FColWidths[1] := UpDown2;
   FColWidths[2] := UpDown3;
   FColWidths[3] := UpDown4;
   FColWidths[4] := UpDown5;
   FColWidths[5] := UpDown6;
   FColWidths[6] := UpDown7;
   FColWidths[7] := UpDown8;
   FColWidths[8] := UpDown9;
   FColWidths[9] := UpDown10;
   FColWidths[10] := UpDown11;
   FColWidths[11] := UpDown12;
   FColWidths[12] := UpDown13;
   FColWidths[13] := UpDown14;
   FColWidths[14] := UpDown15;
   FColWidths[15] := UpDown16;
   FColWidths[16] := UpDown17;
end;

function TformQSOListColumnSettings.GetColumnWidths(Index: Integer): Integer;
begin
   if FColCheckboxes[Index].Checked = True then begin
      Result := FColWidths[Index].Position;
   end
   else begin
      Result := 0;
   end;
end;

procedure TformQSOListColumnSettings.SetColumnWidths(Index: Integer; v: Integer);
begin
   if FColCheckboxes[Index].Checked = True then begin
      FColWidths[Index].Position := v;
   end;
end;

function TformQSOListColumnSettings.GetColumnVisible(Index: Integer): Boolean;
begin
   Result := FColCheckboxes[Index].Checked;
end;

procedure TformQSOListColumnSettings.SetColumnVisible(Index: Integer; v: Boolean);
begin
   FColCheckboxes[Index].Checked := v;
end;

end.
