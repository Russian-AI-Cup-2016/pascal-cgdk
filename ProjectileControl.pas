unit ProjectileControl;

interface

uses
  Math, TypeControl, CircularUnitControl, FactionControl, ProjectileTypeControl;

type
  TProjectile = class (TCircularUnit)
  private
    FType: TProjectileType;
    FOwnerUnitId: Int64;
    FOwnerPlayerId: Int64;

  public
    constructor Create(const id: Int64; const x: Double; const y: Double; const speedX: Double; const speedY: Double;
      const angle: Double; const faction: TFaction; const radius: Double; const projectileType: TProjectileType;
      const ownerUnitId: Int64; const ownerPlayerId: Int64);

    function GetType: TProjectileType;
    property ProjectileType: TProjectileType read GetType;
    function GetOwnerUnitId: Int64;
    property OwnerUnitId: Int64 read GetOwnerUnitId;
    function GetOwnerPlayerId: Int64;
    property OwnerPlayerId: Int64 read GetOwnerPlayerId;

    destructor Destroy; override;

  end;

  TProjectileArray = array of TProjectile;

implementation

constructor TProjectile.Create(const id: Int64; const x: Double; const y: Double; const speedX: Double;
  const speedY: Double; const angle: Double; const faction: TFaction; const radius: Double;
  const projectileType: TProjectileType; const ownerUnitId: Int64; const ownerPlayerId: Int64);
begin
  inherited Create(id, x, y, speedX, speedY, angle, faction, radius);

  FType := projectileType;
  FOwnerUnitId := ownerUnitId;
  FOwnerPlayerId := ownerPlayerId;
end;

function TProjectile.GetType: TProjectileType;
begin
  result := FType;
end;

function TProjectile.GetOwnerUnitId: Int64;
begin
  result := FOwnerUnitId;
end;

function TProjectile.GetOwnerPlayerId: Int64;
begin
  result := FOwnerPlayerId;
end;

destructor TProjectile.Destroy;
begin
  inherited;
end;

end.
