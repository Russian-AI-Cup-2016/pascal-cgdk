unit MinionControl;

interface

uses
  Math, TypeControl, FactionControl, LivingUnitControl, MinionTypeControl, StatusControl;

type
  TMinion = class (TLivingUnit)
  private
    FType: TMinionType;
    FVisionRange: Double;
    FDamage: LongInt;
    FCooldownTicks: LongInt;
    FRemainingActionCooldownTicks: LongInt;

  public
    constructor Create(const id: Int64; const x: Double; const y: Double; const speedX: Double; const speedY: Double;
      const angle: Double; const faction: TFaction; const radius: Double; const life: LongInt; const maxLife: LongInt;
      const statuses: TStatusArray; const minionType: TMinionType; const visionRange: Double; const damage: LongInt;
      const cooldownTicks: LongInt; const remainingActionCooldownTicks: LongInt);

    function GetType: TMinionType;
    property MinionType: TMinionType read GetType;
    function GetVisionRange: Double;
    property VisionRange: Double read GetVisionRange;
    function GetDamage: LongInt;
    property Damage: LongInt read GetDamage;
    function GetCooldownTicks: LongInt;
    property CooldownTicks: LongInt read GetCooldownTicks;
    function GetRemainingActionCooldownTicks: LongInt;
    property RemainingActionCooldownTicks: LongInt read GetRemainingActionCooldownTicks;

    destructor Destroy; override;

  end;

  TMinionArray = array of TMinion;

implementation

constructor TMinion.Create(const id: Int64; const x: Double; const y: Double; const speedX: Double;
  const speedY: Double; const angle: Double; const faction: TFaction; const radius: Double; const life: LongInt;
  const maxLife: LongInt; const statuses: TStatusArray; const minionType: TMinionType; const visionRange: Double;
  const damage: LongInt; const cooldownTicks: LongInt; const remainingActionCooldownTicks: LongInt);
begin
  inherited Create(id, x, y, speedX, speedY, angle, faction, radius, life, maxLife, statuses);

  FType := minionType;
  FVisionRange := visionRange;
  FDamage := damage;
  FCooldownTicks := cooldownTicks;
  FRemainingActionCooldownTicks := remainingActionCooldownTicks;
end;

function TMinion.GetType: TMinionType;
begin
  result := FType;
end;

function TMinion.GetVisionRange: Double;
begin
  result := FVisionRange;
end;

function TMinion.GetDamage: LongInt;
begin
  result := FDamage;
end;

function TMinion.GetCooldownTicks: LongInt;
begin
  result := FCooldownTicks;
end;

function TMinion.GetRemainingActionCooldownTicks: LongInt;
begin
  result := FRemainingActionCooldownTicks;
end;

destructor TMinion.Destroy;
begin
  inherited;
end;

end.
