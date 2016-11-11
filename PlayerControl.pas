unit PlayerControl;

interface

uses
  Math, TypeControl, FactionControl;

type
  TPlayer = class
  private
    FId: Int64;
    FMe: Boolean;
    FName: String;
    FStrategyCrashed: Boolean;
    FScore: LongInt;
    FFaction: TFaction;

  public
    constructor Create(const id: Int64; const me: Boolean; const name: String; const strategyCrashed: Boolean;
      const score: LongInt; const faction: TFaction);

    function GetId: Int64;
    property Id: Int64 read GetId;
    function GetMe: Boolean;
    property IsMe: Boolean read GetMe;
    function GetName: String;
    property Name: String read GetName;
    function GetStrategyCrashed: Boolean;
    property IsStrategyCrashed: Boolean read GetStrategyCrashed;
    function GetScore: LongInt;
    property Score: LongInt read GetScore;
    function GetFaction: TFaction;
    property Faction: TFaction read GetFaction;

    destructor Destroy; override;

  end;

  TPlayerArray = array of TPlayer;

implementation

constructor TPlayer.Create(const id: Int64; const me: Boolean; const name: String; const strategyCrashed: Boolean;
  const score: LongInt; const faction: TFaction);
begin
  FId := id;
  FMe := me;
  FName := name;
  FStrategyCrashed := strategyCrashed;
  FScore := score;
  FFaction := faction;
end;

function TPlayer.GetId: Int64;
begin
  result := FId;
end;

function TPlayer.GetMe: Boolean;
begin
  result := FMe;
end;

function TPlayer.GetName: String;
begin
  result := FName;
end;

function TPlayer.GetStrategyCrashed: Boolean;
begin
  result := FStrategyCrashed;
end;

function TPlayer.GetScore: LongInt;
begin
  result := FScore;
end;

function TPlayer.GetFaction: TFaction;
begin
  result := FFaction;
end;

destructor TPlayer.Destroy;
begin
  inherited;
end;

end.
