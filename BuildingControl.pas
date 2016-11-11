unit BuildingControl;

interface

uses
  Math, TypeControl, BuildingTypeControl, FactionControl, LivingUnitControl, StatusControl;

type
  TBuilding = class (TLivingUnit)
  private
    FType: TBuildingType;
    FVisionRange: Double;
    FAttackRange: Double;
    FDamage: LongInt;
    FCooldownTicks: LongInt;
    FRemainingActionCooldownTicks: LongInt;

  public
    constructor Create(const id: Int64; const x: Double; const y: Double; const speedX: Double; const speedY: Double;
      const angle: Double; const faction: TFaction; const radius: Double; const life: LongInt; const maxLife: LongInt;
      const statuses: TStatusArray; const buildingType: TBuildingType; const visionRange: Double;
      const attackRange: Double; const damage: LongInt; const cooldownTicks: LongInt;
      const remainingActionCooldownTicks: LongInt);

    function GetType: TBuildingType;
    property BuildingType: TBuildingType read GetType;
    function GetVisionRange: Double;
    property VisionRange: Double read GetVisionRange;
    function GetAttackRange: Double;
    property AttackRange: Double read GetAttackRange;
    function GetDamage: LongInt;
    property Damage: LongInt read GetDamage;
    function GetCooldownTicks: LongInt;
    property CooldownTicks: LongInt read GetCooldownTicks;
    function GetRemainingActionCooldownTicks: LongInt;
    property RemainingActionCooldownTicks: LongInt read GetRemainingActionCooldownTicks;

    destructor Destroy; override;

  end;

  TBuildingArray = array of TBuilding;

implementation

constructor TBuilding.Create(const id: Int64; const x: Double; const y: Double; const speedX: Double;
  const speedY: Double; const angle: Double; const faction: TFaction; const radius: Double; const life: LongInt;
  const maxLife: LongInt; const statuses: TStatusArray; const buildingType: TBuildingType; const visionRange: Double;
  const attackRange: Double; const damage: LongInt; const cooldownTicks: LongInt;
  const remainingActionCooldownTicks: LongInt);
begin
  inherited Create(id, x, y, speedX, speedY, angle, faction, radius, life, maxLife, statuses);

  FType := buildingType;
  FVisionRange := visionRange;
  FAttackRange := attackRange;
  FDamage := damage;
  FCooldownTicks := cooldownTicks;
  FRemainingActionCooldownTicks := remainingActionCooldownTicks;
end;

function TBuilding.GetType: TBuildingType;
begin
  result := FType;
end;

function TBuilding.GetVisionRange: Double;
begin
  result := FVisionRange;
end;

function TBuilding.GetAttackRange: Double;
begin
  result := FAttackRange;
end;

function TBuilding.GetDamage: LongInt;
begin
  result := FDamage;
end;

function TBuilding.GetCooldownTicks: LongInt;
begin
  result := FCooldownTicks;
end;

function TBuilding.GetRemainingActionCooldownTicks: LongInt;
begin
  result := FRemainingActionCooldownTicks;
end;

destructor TBuilding.Destroy;
begin
  inherited;
end;

end.
