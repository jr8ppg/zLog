unit UzLogSpc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, Generics.Collections, Generics.Defaults,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TSuperData = class(TObject)
  private
    FDate: TDateTime;
    FCallsign : string;
    FNumber : string;
    function GetText(): string;
  public
    constructor Create(); overload;
    constructor Create(D: TDateTime; C, N: string); overload;
    property Date: TDateTime read FDate write FDate;
    property Callsign: string read FCallsign write FCallsign;
    property Number: string read FNumber write FNumber;
    property Text: string read GetText;
  end;

  TSuperListComparer1 = class(TComparer<TSuperData>)
  public
    function Compare(const Left, Right: TSuperData): Integer; override;
  end;

  TSuperList = class(TObjectList<TSuperData>)
  private
    FCallsignComparer: TSuperListComparer1;
  public
    constructor Create(OwnsObjects: Boolean = True);
    destructor Destroy(); override;
    function IndexOf(SD: TSuperData): Integer;
    function ObjectOf(SD: TSuperData): TSuperData;
    procedure SortByCallsign();
  end;

  TSuperCheckNPlusOneThread = class(TThread)
    procedure Execute(); override;
  private
    FSuperList: TSuperList;
    FListBox: TListBox;
    FPartialStr: string;
  public
    constructor Create(ASuperList: TSuperList; AListBox: TListBox; APartialStr: string);
    property SuperList: TSuperList read FSuperList write FSuperList;
    property ListBox: TListBox read FListBox write FListBox;
    property PartialStr: string read FPartialStr write FPartialStr;
  end;

implementation

{ TSuperData }

constructor TSuperData.Create();
begin
   Inherited;
   FDate := 0;
   FCallsign := '';
   FNumber := '';
end;

constructor TSuperData.Create(D: TDateTime; C, N: string);
begin
   Inherited Create();
   FDate := D;
   FCallsign := C;
   FNumber := N;
end;

function TSuperData.GetText(): string;
begin
   Result := FillRight(callsign, 11) + number;
end;

{ TSuperList }

constructor TSuperList.Create(OwnsObjects: Boolean);
begin
   Inherited Create(OwnsObjects);
   FCallsignComparer := TSuperListComparer1.Create();
end;

destructor TSuperList.Destroy();
begin
   Inherited;
   FCallsignComparer.Free();
end;

function TSuperList.IndexOf(SD: TSuperData): Integer;
var
   Index: Integer;
   i: Integer;
begin
   for i := 0 to Count - 1 do begin
      if SD.Callsign = Items[i].Callsign then begin
         Result := i;
         Exit;
      end;
   end;
   Result := -1;
{
   if BinarySearch(SD, Index, FCallsignComparer) = True then begin
      Result := Index;
   end
   else begin
      Result := -1;
   end;
}
end;

function TSuperList.ObjectOf(SD: TSuperData): TSuperData;
var
   Index: Integer;
   i: Integer;
begin
   for i := 0 to Count - 1 do begin
      if SD.Callsign = Items[i].Callsign then begin
         Result := Items[i];
         Exit;
      end;
   end;
   Result := nil;
{
   if BinarySearch(SD, Index, FCallsignComparer) = True then begin
      Result := Items[Index];
   end
   else begin
      Result := nil;
   end;
}
end;

procedure TSuperList.SortByCallsign();
begin
   Sort(FCallsignComparer);
end;

{ TSuperListComparer1 }

function TSuperListComparer1.Compare(const Left, Right: TSuperData): Integer;
begin
   Result := CompareText(Left.Callsign, Right.Callsign);
end;

{ TSuperCheckNPlusOneThread }

constructor TSuperCheckNPlusOneThread.Create(ASuperList: TSuperList; AListBox: TListBox; APartialStr: string);
begin
   FSuperList := ASuperList;
   FListBox := AListBox;
   FPartialStr := APartialStr;
   Inherited Create();
end;

procedure TSuperCheckNPlusOneThread.Execute();
var
   i: Integer;
   sd: TSuperData;
   hit: Integer;
   maxhit: Integer;
begin
   ListBox.Items.Clear();
   maxhit := dmZlogGlobal.Settings._maxsuperhit;
   hit := 0;
   for i := 0 to FSuperList.Count - 1 do begin
      sd := TSuperData(FSuperList[i]);
      if PartialMatch2(FPartialStr, sd.Callsign) then begin
         ListBox.Items.Add(sd.Callsign);

         Inc(hit);
      end;

      if hit >= maxhit then begin
         break;
      end;
   end;
end;

end.
