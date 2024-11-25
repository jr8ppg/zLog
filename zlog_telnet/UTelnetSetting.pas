unit UTelnetSetting;

interface

uses
  Generics.Collections, Generics.Defaults;

type
  TTelnetSetting = class
  private
    FSettingName: string;
    FHostName: string;
    FPortNumber: Integer;
    FLineBreak: Integer;      // 0:CRLF 1:CR 2:LF
    FLocalEcho: Boolean;
    FLoginId: string;
    FCommandList: string;
  public
    constructor Create();
    destructor Destroy();
    procedure Assign(src: TTelnetSetting);
    property Name: string read FSettingName write FSettingName;
    property HostName: string read FHostName write FHostName;
    property PortNumber: Integer read FPortNumber write FPortNumber;
    property LineBreak: Integer read FLineBreak write FLineBreak;
    property LocalEcho: Boolean read FLocalEcho write FLocalEcho;
    property LoginId: string read FLoginId write FLoginId;
    property CommandList: string read FCommandList write FCommandList;
  end;

  TTelnetSettingList = class(TObjectList<TTelnetSetting>)
  public
    constructor Create(OwnsObjects: Boolean = True);
    destructor Destroy(); override;
  end;

implementation

{ TTelnetSetting }

constructor TTelnetSetting.Create();
begin
   Inherited;
   FSettingName := '';
   FHostName := '';
   FPortNumber := 23;
   FLineBreak := 0;
   FLocalEcho := False;
   FLoginId := '';
   FCommandList := '';
end;

destructor TTelnetSetting.Destroy();
begin
   Inherited;
end;

procedure TTelnetSetting.Assign(src: TTelnetSetting);
begin
   Self.FSettingName := src.FSettingName;
   Self.HostName := src.HostName;
   Self.FPortNumber := src.FPortNumber;
   Self.FLineBreak := src.LineBreak;
   Self.FLocalEcho := src.LocalEcho;
   Self.FLoginId := src.LoginId;
   Self.CommandList := src.CommandList;
end;

{ TTelnetSettingList }

constructor TTelnetSettingList.Create(OwnsObjects: Boolean);
begin
   Inherited Create(OwnsObjects);
end;

destructor TTelnetSettingList.Destroy();
begin
   Inherited;
end;

end.
