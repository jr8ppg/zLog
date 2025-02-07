unit USpcViewer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  UzLogSpc;

type
  TformSpcViewer = class(TForm)
    Panel1: TPanel;
    buttonOK: TButton;
    ListView1: TListView;
    procedure FormCreate(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
    procedure SetList(list: TSuperList);
  end;

implementation

{$R *.dfm}

procedure TformSpcViewer.FormCreate(Sender: TObject);
begin
//
end;

procedure TformSpcViewer.SetList(list: TSuperList);
var
   i: Integer;
   j: Integer;
   SI: TSuperIndex;
   SD: TSuperData;
   listitem: TListItem;
   c: Integer;
begin
   ListView1.Items.BeginUpdate();
   c := 1;
   for i := 0 to list.Count - 1 do begin
      SI := list[i];
      for j := 0 to SI.List.Count - 1 do begin
         SD := SI.List[j];
         listitem := ListView1.Items.Add();
         listitem.Caption := IntToStr(c);
         listitem.SubItems.Add(SI.Callsign);
         listitem.SubItems.Add(IntToStr(SD.Serial));
         listitem.SubItems.Add(SD.Callsign);
         listitem.SubItems.Add(SD.Number);
         listitem.SubItems.Add(IntTostr(SD.RbnCount));
         Inc(c);
      end;
   end;
   ListView1.Items.EndUpdate();
end;

end.
