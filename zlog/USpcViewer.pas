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
    procedure FormResize(Sender: TObject);
  private
    { Private éŒ¾ }
  public
    { Public éŒ¾ }
    procedure SetList(list: TSuperList);
  end;

implementation

{$R *.dfm}

procedure TformSpcViewer.FormCreate(Sender: TObject);
begin
//
end;

procedure TformSpcViewer.FormResize(Sender: TObject);
begin
   buttonOK.Left := (panel1.Width - buttonOK.Width) div 2;
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

      listitem := ListView1.Items.Add();
      listitem.Caption := IntToStr(c);
      listitem.SubItems.Add(SI.Callsign);
      listitem.SubItems.Add(IntTostr(SI.RbnCount));

      for j := 0 to SI.List.Count - 1 do begin
         if j > 4 then begin
            Break;
         end;
         SD := SI.List[j];
         listitem.SubItems.Add(SD.Number);
      end;

      for j := listitem.SubItems.Count + 1 to 7 do begin
         listitem.SubItems.Add('-');
      end;

      Inc(c);
   end;
   ListView1.Items.EndUpdate();
end;

end.
