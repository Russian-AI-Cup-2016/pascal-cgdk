unit RemoteProcessClient;

interface

uses
  SysUtils, SimpleSocket, TypeControl, BonusControl, BonusTypeControl, BuildingControl, BuildingTypeControl,
  CircularUnitControl, FactionControl, GameControl, LaneTypeControl, LivingUnitControl, MessageControl, MinionControl,
  MinionTypeControl, MoveControl, PlayerContextControl, PlayerControl, ProjectileControl, ProjectileTypeControl,
  SkillTypeControl, StatusControl, StatusTypeControl, TreeControl, UnitControl, WizardControl, WorldControl;

const
  UNKNOWN_MESSAGE     : LongInt = 0;
  GAME_OVER           : LongInt = 1;
  AUTHENTICATION_TOKEN: LongInt = 2;
  TEAM_SIZE           : LongInt = 3;
  PROTOCOL_VERSION    : LongInt = 4;
  GAME_CONTEXT        : LongInt = 5;
  PLAYER_CONTEXT      : LongInt = 6;
  MOVES_MESSAGE       : LongInt = 7;

  LITTLE_ENDIAN_BYTE_ORDER = true;
  INTEGER_SIZE_BYTES = sizeof(LongInt);
  LONG_SIZE_BYTES = sizeof(Int64);

type
  TMessageType = LongInt;

  TRemoteProcessClient = class
  private
    FSocket: ClientSocket;

    FPreviousTrees: TTreeArray;

    {$HINTS OFF}
    function ReadBonus: TBonus;
    procedure WriteBonus(bonus: TBonus);
    function ReadBonuses: TBonusArray;
    procedure WriteBonuses(bonuses: TBonusArray);
    function ReadBuilding: TBuilding;
    procedure WriteBuilding(building: TBuilding);
    function ReadBuildings: TBuildingArray;
    procedure WriteBuildings(buildings: TBuildingArray);
    function ReadGame: TGame;
    procedure WriteGame(game: TGame);
    function ReadGames: TGameArray;
    procedure WriteGames(games: TGameArray);
    function ReadMessage: TMessage;
    procedure WriteMessage(message: TMessage);
    function ReadMessages: TMessageArray;
    procedure WriteMessages(messages: TMessageArray);
    function ReadMinion: TMinion;
    procedure WriteMinion(minion: TMinion);
    function ReadMinions: TMinionArray;
    procedure WriteMinions(minions: TMinionArray);
    procedure WriteMove(move: TMove);
    procedure WriteMoves(moves: TMoveArray);
    function ReadPlayer: TPlayer;
    procedure WritePlayer(player: TPlayer);
    function ReadPlayers: TPlayerArray;
    procedure WritePlayers(players: TPlayerArray);
    function ReadPlayerContext: TPlayerContext;
    procedure WritePlayerContext(playerContext: TPlayerContext);
    function ReadPlayerContexts: TPlayerContextArray;
    procedure WritePlayerContexts(playerContexts: TPlayerContextArray);
    function ReadProjectile: TProjectile;
    procedure WriteProjectile(projectile: TProjectile);
    function ReadProjectiles: TProjectileArray;
    procedure WriteProjectiles(projectiles: TProjectileArray);
    function ReadStatus: TStatus;
    procedure WriteStatus(status: TStatus);
    function ReadStatuses: TStatusArray;
    procedure WriteStatuses(statuses: TStatusArray);
    function ReadTree: TTree;
    procedure WriteTree(tree: TTree);
    function ReadTrees: TTreeArray;
    procedure WriteTrees(trees: TTreeArray);
    function ReadWizard: TWizard;
    procedure WriteWizard(wizard: TWizard);
    function ReadWizards: TWizardArray;
    procedure WriteWizards(wizards: TWizardArray);
    function ReadWorld: TWorld;
    procedure WriteWorld(world: TWorld);
    function ReadWorlds: TWorldArray;
    procedure WriteWorlds(worlds: TWorldArray);
    {$HINTS ON}

    procedure EnsureMessageType(actualType: LongInt; expectedType: LongInt);

    {$HINTS OFF}
    function ReadByteArray(nullable: Boolean): TByteArray;
    procedure WriteByteArray(value: TByteArray);

    function ReadEnum: LongInt;
    function ReadEnumArray: TLongIntArray;
    function ReadEnumArray2D: TLongIntArray2D;
    procedure WriteEnum(value: LongInt);
    procedure WriteEnumArray(value: TLongIntArray);
    procedure WriteEnumArray2D(value: TLongIntArray2D);

    function ReadString: String;
    procedure WriteString(value: String);

    function ReadInt: LongInt;
    function ReadIntArray: TLongIntArray;
    function ReadIntArray2D: TLongIntArray2D;
    procedure WriteInt(value: LongInt);
    procedure WriteIntArray(value: TLongIntArray);
    procedure WriteIntArray2D(value: TLongIntArray2D);

    function ReadBytes(byteCount: LongInt): TByteArray;
    procedure WriteBytes(bytes: TByteArray);

    function ReadBoolean: Boolean;
    procedure WriteBoolean(value: Boolean);

    function ReadDouble: Double;
    procedure WriteDouble(value: Double);

    function ReadLong: Int64;
    procedure WriteLong(value: Int64);
    {$HINTS ON}

    function IsLittleEndianMachine: Boolean;

    procedure Reverse(var bytes: TByteArray);

  public
    constructor Create(host: String; port: LongInt);

    procedure WriteTokenMessage(token: String);
    procedure WriteProtocolVersionMessage;
    function ReadTeamSizeMessage: LongInt;
    function ReadGameContextMessage: TGame;
    function ReadPlayerContextMessage: TPlayerContext;
    procedure WriteMovesMessage(moves: TMoveArray);

    destructor Destroy; override;

end;

implementation

constructor TRemoteProcessClient.Create(host: String; port: LongInt);
begin
  FSocket := ClientSocket.Create(host, port);
  FPreviousTrees := nil;
end;

procedure TRemoteProcessClient.EnsureMessageType(actualType: LongInt; expectedType: LongInt);
begin
  if (actualType <> expectedType) then begin
    HALT(10001);
  end;
end;

procedure TRemoteProcessClient.WriteTokenMessage(token: String);
begin
  WriteEnum(AUTHENTICATION_TOKEN);
  WriteString(token);
end;

procedure TRemoteProcessClient.WriteProtocolVersionMessage;
begin
  WriteEnum(PROTOCOL_VERSION);
  WriteInt(1);
end;

function TRemoteProcessClient.ReadTeamSizeMessage: LongInt;
begin
  EnsureMessageType(ReadEnum, TEAM_SIZE);
  result := ReadInt;
end;

function TRemoteProcessClient.ReadGameContextMessage: TGame;
begin
  EnsureMessageType(ReadEnum, GAME_CONTEXT);
  result := ReadGame;
end;

function TRemoteProcessClient.ReadPlayerContextMessage: TPlayerContext;
var
  messageType: TMessageType;

begin
  messageType := ReadEnum;
  if messageType = GAME_OVER then begin
    result := nil;
    exit;
  end;

  EnsureMessageType(messageType, PLAYER_CONTEXT);
  result := ReadPlayerContext;
end;

procedure TRemoteProcessClient.WriteMovesMessage(moves: TMoveArray);
begin
  WriteEnum(MOVES_MESSAGE);
  WriteMoves(moves);
end;

function TRemoteProcessClient.ReadBonus: TBonus;
var
  id: Int64;
  x: Double;
  y: Double;
  speedX: Double;
  speedY: Double;
  angle: Double;
  faction: TFaction;
  radius: Double;
  bonusType: TBonusType;

begin
  if not ReadBoolean then begin
    result := nil;
    exit;
  end;

  id := ReadLong;
  x := ReadDouble;
  y := ReadDouble;
  speedX := ReadDouble;
  speedY := ReadDouble;
  angle := ReadDouble;
  faction := ReadEnum;
  radius := ReadDouble;
  bonusType := ReadEnum;

  result := TBonus.Create(id, x, y, speedX, speedY, angle, faction, radius, bonusType);
end;

procedure TRemoteProcessClient.WriteBonus(bonus: TBonus);
begin
  if bonus = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteLong(bonus.GetId);
  WriteDouble(bonus.GetX);
  WriteDouble(bonus.GetY);
  WriteDouble(bonus.GetSpeedX);
  WriteDouble(bonus.GetSpeedY);
  WriteDouble(bonus.GetAngle);
  WriteEnum(bonus.GetFaction);
  WriteDouble(bonus.GetRadius);
  WriteEnum(bonus.GetType);
end;

function TRemoteProcessClient.ReadBonuses: TBonusArray;
var
  bonusIndex: LongInt;
  bonusCount: LongInt;

begin
  bonusCount := ReadInt;
  if bonusCount < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, bonusCount);

  for bonusIndex := 0 to bonusCount - 1 do begin
    result[bonusIndex] := ReadBonus;
  end;
end;

procedure TRemoteProcessClient.WriteBonuses(bonuses: TBonusArray);
var
  bonusIndex: LongInt;
  bonusCount: LongInt;

begin
  if bonuses = nil then begin
    WriteInt(-1);
    exit;
  end;

  bonusCount := Length(bonuses);
  WriteInt(bonusCount);

  for bonusIndex := 0 to bonusCount - 1 do begin
    WriteBonus(bonuses[bonusIndex]);
  end;
end;

function TRemoteProcessClient.ReadBuilding: TBuilding;
var
  id: Int64;
  x: Double;
  y: Double;
  speedX: Double;
  speedY: Double;
  angle: Double;
  faction: TFaction;
  radius: Double;
  life: LongInt;
  maxLife: LongInt;
  statuses: TStatusArray;
  buildingType: TBuildingType;
  visionRange: Double;
  attackRange: Double;
  damage: LongInt;
  cooldownTicks: LongInt;
  remainingActionCooldownTicks: LongInt;

begin
  if not ReadBoolean then begin
    result := nil;
    exit;
  end;

  id := ReadLong;
  x := ReadDouble;
  y := ReadDouble;
  speedX := ReadDouble;
  speedY := ReadDouble;
  angle := ReadDouble;
  faction := ReadEnum;
  radius := ReadDouble;
  life := ReadInt;
  maxLife := ReadInt;
  statuses := ReadStatuses;
  buildingType := ReadEnum;
  visionRange := ReadDouble;
  attackRange := ReadDouble;
  damage := ReadInt;
  cooldownTicks := ReadInt;
  remainingActionCooldownTicks := ReadInt;

  result := TBuilding.Create(id, x, y, speedX, speedY, angle, faction, radius, life, maxLife, statuses, buildingType,
    visionRange, attackRange, damage, cooldownTicks, remainingActionCooldownTicks);
end;

procedure TRemoteProcessClient.WriteBuilding(building: TBuilding);
begin
  if building = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteLong(building.GetId);
  WriteDouble(building.GetX);
  WriteDouble(building.GetY);
  WriteDouble(building.GetSpeedX);
  WriteDouble(building.GetSpeedY);
  WriteDouble(building.GetAngle);
  WriteEnum(building.GetFaction);
  WriteDouble(building.GetRadius);
  WriteInt(building.GetLife);
  WriteInt(building.GetMaxLife);
  WriteStatuses(building.GetStatuses);
  WriteEnum(building.GetType);
  WriteDouble(building.GetVisionRange);
  WriteDouble(building.GetAttackRange);
  WriteInt(building.GetDamage);
  WriteInt(building.GetCooldownTicks);
  WriteInt(building.GetRemainingActionCooldownTicks);
end;

function TRemoteProcessClient.ReadBuildings: TBuildingArray;
var
  buildingIndex: LongInt;
  buildingCount: LongInt;

begin
  buildingCount := ReadInt;
  if buildingCount < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, buildingCount);

  for buildingIndex := 0 to buildingCount - 1 do begin
    result[buildingIndex] := ReadBuilding;
  end;
end;

procedure TRemoteProcessClient.WriteBuildings(buildings: TBuildingArray);
var
  buildingIndex: LongInt;
  buildingCount: LongInt;

begin
  if buildings = nil then begin
    WriteInt(-1);
    exit;
  end;

  buildingCount := Length(buildings);
  WriteInt(buildingCount);

  for buildingIndex := 0 to buildingCount - 1 do begin
    WriteBuilding(buildings[buildingIndex]);
  end;
end;

function TRemoteProcessClient.ReadGame: TGame;
var
  randomSeed: Int64;
  tickCount: LongInt;
  mapSize: Double;
  skillsEnabled: Boolean;
  rawMessagesEnabled: Boolean;
  friendlyFireDamageFactor: Double;
  buildingDamageScoreFactor: Double;
  buildingEliminationScoreFactor: Double;
  minionDamageScoreFactor: Double;
  minionEliminationScoreFactor: Double;
  wizardDamageScoreFactor: Double;
  wizardEliminationScoreFactor: Double;
  teamWorkingScoreFactor: Double;
  victoryScore: LongInt;
  scoreGainRange: Double;
  rawMessageMaxLength: LongInt;
  rawMessageTransmissionSpeed: Double;
  wizardRadius: Double;
  wizardCastRange: Double;
  wizardVisionRange: Double;
  wizardForwardSpeed: Double;
  wizardBackwardSpeed: Double;
  wizardStrafeSpeed: Double;
  wizardBaseLife: LongInt;
  wizardLifeGrowthPerLevel: LongInt;
  wizardBaseMana: LongInt;
  wizardManaGrowthPerLevel: LongInt;
  wizardBaseLifeRegeneration: Double;
  wizardLifeRegenerationGrowthPerLevel: Double;
  wizardBaseManaRegeneration: Double;
  wizardManaRegenerationGrowthPerLevel: Double;
  wizardMaxTurnAngle: Double;
  wizardMaxResurrectionDelayTicks: LongInt;
  wizardMinResurrectionDelayTicks: LongInt;
  wizardActionCooldownTicks: LongInt;
  staffCooldownTicks: LongInt;
  magicMissileCooldownTicks: LongInt;
  frostBoltCooldownTicks: LongInt;
  fireballCooldownTicks: LongInt;
  hasteCooldownTicks: LongInt;
  shieldCooldownTicks: LongInt;
  magicMissileManacost: LongInt;
  frostBoltManacost: LongInt;
  fireballManacost: LongInt;
  hasteManacost: LongInt;
  shieldManacost: LongInt;
  staffDamage: LongInt;
  staffSector: Double;
  staffRange: Double;
  levelUpXpValues: TLongIntArray;
  minionRadius: Double;
  minionVisionRange: Double;
  minionSpeed: Double;
  minionMaxTurnAngle: Double;
  minionLife: LongInt;
  factionMinionAppearanceIntervalTicks: LongInt;
  orcWoodcutterActionCooldownTicks: LongInt;
  orcWoodcutterDamage: LongInt;
  orcWoodcutterAttackSector: Double;
  orcWoodcutterAttackRange: Double;
  fetishBlowdartActionCooldownTicks: LongInt;
  fetishBlowdartAttackRange: Double;
  fetishBlowdartAttackSector: Double;
  bonusRadius: Double;
  bonusAppearanceIntervalTicks: LongInt;
  bonusScoreAmount: LongInt;
  dartRadius: Double;
  dartSpeed: Double;
  dartDirectDamage: LongInt;
  magicMissileRadius: Double;
  magicMissileSpeed: Double;
  magicMissileDirectDamage: LongInt;
  frostBoltRadius: Double;
  frostBoltSpeed: Double;
  frostBoltDirectDamage: LongInt;
  fireballRadius: Double;
  fireballSpeed: Double;
  fireballExplosionMaxDamageRange: Double;
  fireballExplosionMinDamageRange: Double;
  fireballExplosionMaxDamage: LongInt;
  fireballExplosionMinDamage: LongInt;
  guardianTowerRadius: Double;
  guardianTowerVisionRange: Double;
  guardianTowerLife: Double;
  guardianTowerAttackRange: Double;
  guardianTowerDamage: LongInt;
  guardianTowerCooldownTicks: LongInt;
  factionBaseRadius: Double;
  factionBaseVisionRange: Double;
  factionBaseLife: Double;
  factionBaseAttackRange: Double;
  factionBaseDamage: LongInt;
  factionBaseCooldownTicks: LongInt;
  burningDurationTicks: LongInt;
  burningSummaryDamage: LongInt;
  empoweredDurationTicks: LongInt;
  empoweredDamageFactor: Double;
  frozenDurationTicks: LongInt;
  hastenedDurationTicks: LongInt;
  hastenedBonusDurationFactor: Double;
  hastenedMovementBonusFactor: Double;
  hastenedRotationBonusFactor: Double;
  shieldedDurationTicks: LongInt;
  shieldedBonusDurationFactor: Double;
  shieldedDirectDamageAbsorptionFactor: Double;
  auraSkillRange: Double;
  rangeBonusPerSkillLevel: Double;
  magicalDamageBonusPerSkillLevel: LongInt;
  staffDamageBonusPerSkillLevel: LongInt;
  movementBonusFactorPerSkillLevel: Double;
  magicalDamageAbsorptionPerSkillLevel: LongInt;

begin
  if not ReadBoolean then begin
    result := nil;
    exit;
  end;

  randomSeed := ReadLong;
  tickCount := ReadInt;
  mapSize := ReadDouble;
  skillsEnabled := ReadBoolean;
  rawMessagesEnabled := ReadBoolean;
  friendlyFireDamageFactor := ReadDouble;
  buildingDamageScoreFactor := ReadDouble;
  buildingEliminationScoreFactor := ReadDouble;
  minionDamageScoreFactor := ReadDouble;
  minionEliminationScoreFactor := ReadDouble;
  wizardDamageScoreFactor := ReadDouble;
  wizardEliminationScoreFactor := ReadDouble;
  teamWorkingScoreFactor := ReadDouble;
  victoryScore := ReadInt;
  scoreGainRange := ReadDouble;
  rawMessageMaxLength := ReadInt;
  rawMessageTransmissionSpeed := ReadDouble;
  wizardRadius := ReadDouble;
  wizardCastRange := ReadDouble;
  wizardVisionRange := ReadDouble;
  wizardForwardSpeed := ReadDouble;
  wizardBackwardSpeed := ReadDouble;
  wizardStrafeSpeed := ReadDouble;
  wizardBaseLife := ReadInt;
  wizardLifeGrowthPerLevel := ReadInt;
  wizardBaseMana := ReadInt;
  wizardManaGrowthPerLevel := ReadInt;
  wizardBaseLifeRegeneration := ReadDouble;
  wizardLifeRegenerationGrowthPerLevel := ReadDouble;
  wizardBaseManaRegeneration := ReadDouble;
  wizardManaRegenerationGrowthPerLevel := ReadDouble;
  wizardMaxTurnAngle := ReadDouble;
  wizardMaxResurrectionDelayTicks := ReadInt;
  wizardMinResurrectionDelayTicks := ReadInt;
  wizardActionCooldownTicks := ReadInt;
  staffCooldownTicks := ReadInt;
  magicMissileCooldownTicks := ReadInt;
  frostBoltCooldownTicks := ReadInt;
  fireballCooldownTicks := ReadInt;
  hasteCooldownTicks := ReadInt;
  shieldCooldownTicks := ReadInt;
  magicMissileManacost := ReadInt;
  frostBoltManacost := ReadInt;
  fireballManacost := ReadInt;
  hasteManacost := ReadInt;
  shieldManacost := ReadInt;
  staffDamage := ReadInt;
  staffSector := ReadDouble;
  staffRange := ReadDouble;
  levelUpXpValues := ReadIntArray;
  minionRadius := ReadDouble;
  minionVisionRange := ReadDouble;
  minionSpeed := ReadDouble;
  minionMaxTurnAngle := ReadDouble;
  minionLife := ReadInt;
  factionMinionAppearanceIntervalTicks := ReadInt;
  orcWoodcutterActionCooldownTicks := ReadInt;
  orcWoodcutterDamage := ReadInt;
  orcWoodcutterAttackSector := ReadDouble;
  orcWoodcutterAttackRange := ReadDouble;
  fetishBlowdartActionCooldownTicks := ReadInt;
  fetishBlowdartAttackRange := ReadDouble;
  fetishBlowdartAttackSector := ReadDouble;
  bonusRadius := ReadDouble;
  bonusAppearanceIntervalTicks := ReadInt;
  bonusScoreAmount := ReadInt;
  dartRadius := ReadDouble;
  dartSpeed := ReadDouble;
  dartDirectDamage := ReadInt;
  magicMissileRadius := ReadDouble;
  magicMissileSpeed := ReadDouble;
  magicMissileDirectDamage := ReadInt;
  frostBoltRadius := ReadDouble;
  frostBoltSpeed := ReadDouble;
  frostBoltDirectDamage := ReadInt;
  fireballRadius := ReadDouble;
  fireballSpeed := ReadDouble;
  fireballExplosionMaxDamageRange := ReadDouble;
  fireballExplosionMinDamageRange := ReadDouble;
  fireballExplosionMaxDamage := ReadInt;
  fireballExplosionMinDamage := ReadInt;
  guardianTowerRadius := ReadDouble;
  guardianTowerVisionRange := ReadDouble;
  guardianTowerLife := ReadDouble;
  guardianTowerAttackRange := ReadDouble;
  guardianTowerDamage := ReadInt;
  guardianTowerCooldownTicks := ReadInt;
  factionBaseRadius := ReadDouble;
  factionBaseVisionRange := ReadDouble;
  factionBaseLife := ReadDouble;
  factionBaseAttackRange := ReadDouble;
  factionBaseDamage := ReadInt;
  factionBaseCooldownTicks := ReadInt;
  burningDurationTicks := ReadInt;
  burningSummaryDamage := ReadInt;
  empoweredDurationTicks := ReadInt;
  empoweredDamageFactor := ReadDouble;
  frozenDurationTicks := ReadInt;
  hastenedDurationTicks := ReadInt;
  hastenedBonusDurationFactor := ReadDouble;
  hastenedMovementBonusFactor := ReadDouble;
  hastenedRotationBonusFactor := ReadDouble;
  shieldedDurationTicks := ReadInt;
  shieldedBonusDurationFactor := ReadDouble;
  shieldedDirectDamageAbsorptionFactor := ReadDouble;
  auraSkillRange := ReadDouble;
  rangeBonusPerSkillLevel := ReadDouble;
  magicalDamageBonusPerSkillLevel := ReadInt;
  staffDamageBonusPerSkillLevel := ReadInt;
  movementBonusFactorPerSkillLevel := ReadDouble;
  magicalDamageAbsorptionPerSkillLevel := ReadInt;

  result := TGame.Create(randomSeed, tickCount, mapSize, skillsEnabled, rawMessagesEnabled, friendlyFireDamageFactor,
    buildingDamageScoreFactor, buildingEliminationScoreFactor, minionDamageScoreFactor, minionEliminationScoreFactor,
    wizardDamageScoreFactor, wizardEliminationScoreFactor, teamWorkingScoreFactor, victoryScore, scoreGainRange,
    rawMessageMaxLength, rawMessageTransmissionSpeed, wizardRadius, wizardCastRange, wizardVisionRange,
    wizardForwardSpeed, wizardBackwardSpeed, wizardStrafeSpeed, wizardBaseLife, wizardLifeGrowthPerLevel, wizardBaseMana,
    wizardManaGrowthPerLevel, wizardBaseLifeRegeneration, wizardLifeRegenerationGrowthPerLevel,
    wizardBaseManaRegeneration, wizardManaRegenerationGrowthPerLevel, wizardMaxTurnAngle, wizardMaxResurrectionDelayTicks,
    wizardMinResurrectionDelayTicks, wizardActionCooldownTicks, staffCooldownTicks, magicMissileCooldownTicks,
    frostBoltCooldownTicks, fireballCooldownTicks, hasteCooldownTicks, shieldCooldownTicks, magicMissileManacost,
    frostBoltManacost, fireballManacost, hasteManacost, shieldManacost, staffDamage, staffSector, staffRange,
    levelUpXpValues, minionRadius, minionVisionRange, minionSpeed, minionMaxTurnAngle, minionLife,
    factionMinionAppearanceIntervalTicks, orcWoodcutterActionCooldownTicks, orcWoodcutterDamage,
    orcWoodcutterAttackSector, orcWoodcutterAttackRange, fetishBlowdartActionCooldownTicks, fetishBlowdartAttackRange,
    fetishBlowdartAttackSector, bonusRadius, bonusAppearanceIntervalTicks, bonusScoreAmount, dartRadius, dartSpeed,
    dartDirectDamage, magicMissileRadius, magicMissileSpeed, magicMissileDirectDamage, frostBoltRadius, frostBoltSpeed,
    frostBoltDirectDamage, fireballRadius, fireballSpeed, fireballExplosionMaxDamageRange,
    fireballExplosionMinDamageRange, fireballExplosionMaxDamage, fireballExplosionMinDamage, guardianTowerRadius,
    guardianTowerVisionRange, guardianTowerLife, guardianTowerAttackRange, guardianTowerDamage,
    guardianTowerCooldownTicks, factionBaseRadius, factionBaseVisionRange, factionBaseLife, factionBaseAttackRange,
    factionBaseDamage, factionBaseCooldownTicks, burningDurationTicks, burningSummaryDamage, empoweredDurationTicks,
    empoweredDamageFactor, frozenDurationTicks, hastenedDurationTicks, hastenedBonusDurationFactor,
    hastenedMovementBonusFactor, hastenedRotationBonusFactor, shieldedDurationTicks, shieldedBonusDurationFactor,
    shieldedDirectDamageAbsorptionFactor, auraSkillRange, rangeBonusPerSkillLevel, magicalDamageBonusPerSkillLevel,
    staffDamageBonusPerSkillLevel, movementBonusFactorPerSkillLevel, magicalDamageAbsorptionPerSkillLevel);
end;

procedure TRemoteProcessClient.WriteGame(game: TGame);
begin
  if game = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteLong(game.GetRandomSeed);
  WriteInt(game.GetTickCount);
  WriteDouble(game.GetMapSize);
  WriteBoolean(game.GetSkillsEnabled);
  WriteBoolean(game.GetRawMessagesEnabled);
  WriteDouble(game.GetFriendlyFireDamageFactor);
  WriteDouble(game.GetBuildingDamageScoreFactor);
  WriteDouble(game.GetBuildingEliminationScoreFactor);
  WriteDouble(game.GetMinionDamageScoreFactor);
  WriteDouble(game.GetMinionEliminationScoreFactor);
  WriteDouble(game.GetWizardDamageScoreFactor);
  WriteDouble(game.GetWizardEliminationScoreFactor);
  WriteDouble(game.GetTeamWorkingScoreFactor);
  WriteInt(game.GetVictoryScore);
  WriteDouble(game.GetScoreGainRange);
  WriteInt(game.GetRawMessageMaxLength);
  WriteDouble(game.GetRawMessageTransmissionSpeed);
  WriteDouble(game.GetWizardRadius);
  WriteDouble(game.GetWizardCastRange);
  WriteDouble(game.GetWizardVisionRange);
  WriteDouble(game.GetWizardForwardSpeed);
  WriteDouble(game.GetWizardBackwardSpeed);
  WriteDouble(game.GetWizardStrafeSpeed);
  WriteInt(game.GetWizardBaseLife);
  WriteInt(game.GetWizardLifeGrowthPerLevel);
  WriteInt(game.GetWizardBaseMana);
  WriteInt(game.GetWizardManaGrowthPerLevel);
  WriteDouble(game.GetWizardBaseLifeRegeneration);
  WriteDouble(game.GetWizardLifeRegenerationGrowthPerLevel);
  WriteDouble(game.GetWizardBaseManaRegeneration);
  WriteDouble(game.GetWizardManaRegenerationGrowthPerLevel);
  WriteDouble(game.GetWizardMaxTurnAngle);
  WriteInt(game.GetWizardMaxResurrectionDelayTicks);
  WriteInt(game.GetWizardMinResurrectionDelayTicks);
  WriteInt(game.GetWizardActionCooldownTicks);
  WriteInt(game.GetStaffCooldownTicks);
  WriteInt(game.GetMagicMissileCooldownTicks);
  WriteInt(game.GetFrostBoltCooldownTicks);
  WriteInt(game.GetFireballCooldownTicks);
  WriteInt(game.GetHasteCooldownTicks);
  WriteInt(game.GetShieldCooldownTicks);
  WriteInt(game.GetMagicMissileManacost);
  WriteInt(game.GetFrostBoltManacost);
  WriteInt(game.GetFireballManacost);
  WriteInt(game.GetHasteManacost);
  WriteInt(game.GetShieldManacost);
  WriteInt(game.GetStaffDamage);
  WriteDouble(game.GetStaffSector);
  WriteDouble(game.GetStaffRange);
  WriteIntArray(game.GetLevelUpXpValues);
  WriteDouble(game.GetMinionRadius);
  WriteDouble(game.GetMinionVisionRange);
  WriteDouble(game.GetMinionSpeed);
  WriteDouble(game.GetMinionMaxTurnAngle);
  WriteInt(game.GetMinionLife);
  WriteInt(game.GetFactionMinionAppearanceIntervalTicks);
  WriteInt(game.GetOrcWoodcutterActionCooldownTicks);
  WriteInt(game.GetOrcWoodcutterDamage);
  WriteDouble(game.GetOrcWoodcutterAttackSector);
  WriteDouble(game.GetOrcWoodcutterAttackRange);
  WriteInt(game.GetFetishBlowdartActionCooldownTicks);
  WriteDouble(game.GetFetishBlowdartAttackRange);
  WriteDouble(game.GetFetishBlowdartAttackSector);
  WriteDouble(game.GetBonusRadius);
  WriteInt(game.GetBonusAppearanceIntervalTicks);
  WriteInt(game.GetBonusScoreAmount);
  WriteDouble(game.GetDartRadius);
  WriteDouble(game.GetDartSpeed);
  WriteInt(game.GetDartDirectDamage);
  WriteDouble(game.GetMagicMissileRadius);
  WriteDouble(game.GetMagicMissileSpeed);
  WriteInt(game.GetMagicMissileDirectDamage);
  WriteDouble(game.GetFrostBoltRadius);
  WriteDouble(game.GetFrostBoltSpeed);
  WriteInt(game.GetFrostBoltDirectDamage);
  WriteDouble(game.GetFireballRadius);
  WriteDouble(game.GetFireballSpeed);
  WriteDouble(game.GetFireballExplosionMaxDamageRange);
  WriteDouble(game.GetFireballExplosionMinDamageRange);
  WriteInt(game.GetFireballExplosionMaxDamage);
  WriteInt(game.GetFireballExplosionMinDamage);
  WriteDouble(game.GetGuardianTowerRadius);
  WriteDouble(game.GetGuardianTowerVisionRange);
  WriteDouble(game.GetGuardianTowerLife);
  WriteDouble(game.GetGuardianTowerAttackRange);
  WriteInt(game.GetGuardianTowerDamage);
  WriteInt(game.GetGuardianTowerCooldownTicks);
  WriteDouble(game.GetFactionBaseRadius);
  WriteDouble(game.GetFactionBaseVisionRange);
  WriteDouble(game.GetFactionBaseLife);
  WriteDouble(game.GetFactionBaseAttackRange);
  WriteInt(game.GetFactionBaseDamage);
  WriteInt(game.GetFactionBaseCooldownTicks);
  WriteInt(game.GetBurningDurationTicks);
  WriteInt(game.GetBurningSummaryDamage);
  WriteInt(game.GetEmpoweredDurationTicks);
  WriteDouble(game.GetEmpoweredDamageFactor);
  WriteInt(game.GetFrozenDurationTicks);
  WriteInt(game.GetHastenedDurationTicks);
  WriteDouble(game.GetHastenedBonusDurationFactor);
  WriteDouble(game.GetHastenedMovementBonusFactor);
  WriteDouble(game.GetHastenedRotationBonusFactor);
  WriteInt(game.GetShieldedDurationTicks);
  WriteDouble(game.GetShieldedBonusDurationFactor);
  WriteDouble(game.GetShieldedDirectDamageAbsorptionFactor);
  WriteDouble(game.GetAuraSkillRange);
  WriteDouble(game.GetRangeBonusPerSkillLevel);
  WriteInt(game.GetMagicalDamageBonusPerSkillLevel);
  WriteInt(game.GetStaffDamageBonusPerSkillLevel);
  WriteDouble(game.GetMovementBonusFactorPerSkillLevel);
  WriteInt(game.GetMagicalDamageAbsorptionPerSkillLevel);
end;

function TRemoteProcessClient.ReadGames: TGameArray;
var
  gameIndex: LongInt;
  gameCount: LongInt;

begin
  gameCount := ReadInt;
  if gameCount < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, gameCount);

  for gameIndex := 0 to gameCount - 1 do begin
    result[gameIndex] := ReadGame;
  end;
end;

procedure TRemoteProcessClient.WriteGames(games: TGameArray);
var
  gameIndex: LongInt;
  gameCount: LongInt;

begin
  if games = nil then begin
    WriteInt(-1);
    exit;
  end;

  gameCount := Length(games);
  WriteInt(gameCount);

  for gameIndex := 0 to gameCount - 1 do begin
    WriteGame(games[gameIndex]);
  end;
end;

function TRemoteProcessClient.ReadMessage: TMessage;
var
  lane: TLaneType;
  skillToLearn: TSkillType;
  rawMessage: TbyteArray;

begin
  if not ReadBoolean then begin
    result := nil;
    exit;
  end;

  lane := ReadEnum;
  skillToLearn := ReadEnum;
  rawMessage := ReadByteArray(false);

  result := TMessage.Create(lane, skillToLearn, rawMessage);
end;

procedure TRemoteProcessClient.WriteMessage(message: TMessage);
begin
  if message = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteEnum(message.GetLane);
  WriteEnum(message.GetSkillToLearn);
  WriteByteArray(message.GetRawMessage);
end;

function TRemoteProcessClient.ReadMessages: TMessageArray;
var
  messageIndex: LongInt;
  messageCount: LongInt;

begin
  messageCount := ReadInt;
  if messageCount < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, messageCount);

  for messageIndex := 0 to messageCount - 1 do begin
    result[messageIndex] := ReadMessage;
  end;
end;

procedure TRemoteProcessClient.WriteMessages(messages: TMessageArray);
var
  messageIndex: LongInt;
  messageCount: LongInt;

begin
  if messages = nil then begin
    WriteInt(-1);
    exit;
  end;

  messageCount := Length(messages);
  WriteInt(messageCount);

  for messageIndex := 0 to messageCount - 1 do begin
    WriteMessage(messages[messageIndex]);
  end;
end;

function TRemoteProcessClient.ReadMinion: TMinion;
var
  id: Int64;
  x: Double;
  y: Double;
  speedX: Double;
  speedY: Double;
  angle: Double;
  faction: TFaction;
  radius: Double;
  life: LongInt;
  maxLife: LongInt;
  statuses: TStatusArray;
  minionType: TMinionType;
  visionRange: Double;
  damage: LongInt;
  cooldownTicks: LongInt;
  remainingActionCooldownTicks: LongInt;

begin
  if not ReadBoolean then begin
    result := nil;
    exit;
  end;

  id := ReadLong;
  x := ReadDouble;
  y := ReadDouble;
  speedX := ReadDouble;
  speedY := ReadDouble;
  angle := ReadDouble;
  faction := ReadEnum;
  radius := ReadDouble;
  life := ReadInt;
  maxLife := ReadInt;
  statuses := ReadStatuses;
  minionType := ReadEnum;
  visionRange := ReadDouble;
  damage := ReadInt;
  cooldownTicks := ReadInt;
  remainingActionCooldownTicks := ReadInt;

  result := TMinion.Create(id, x, y, speedX, speedY, angle, faction, radius, life, maxLife, statuses, minionType,
    visionRange, damage, cooldownTicks, remainingActionCooldownTicks);
end;

procedure TRemoteProcessClient.WriteMinion(minion: TMinion);
begin
  if minion = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteLong(minion.GetId);
  WriteDouble(minion.GetX);
  WriteDouble(minion.GetY);
  WriteDouble(minion.GetSpeedX);
  WriteDouble(minion.GetSpeedY);
  WriteDouble(minion.GetAngle);
  WriteEnum(minion.GetFaction);
  WriteDouble(minion.GetRadius);
  WriteInt(minion.GetLife);
  WriteInt(minion.GetMaxLife);
  WriteStatuses(minion.GetStatuses);
  WriteEnum(minion.GetType);
  WriteDouble(minion.GetVisionRange);
  WriteInt(minion.GetDamage);
  WriteInt(minion.GetCooldownTicks);
  WriteInt(minion.GetRemainingActionCooldownTicks);
end;

function TRemoteProcessClient.ReadMinions: TMinionArray;
var
  minionIndex: LongInt;
  minionCount: LongInt;

begin
  minionCount := ReadInt;
  if minionCount < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, minionCount);

  for minionIndex := 0 to minionCount - 1 do begin
    result[minionIndex] := ReadMinion;
  end;
end;

procedure TRemoteProcessClient.WriteMinions(minions: TMinionArray);
var
  minionIndex: LongInt;
  minionCount: LongInt;

begin
  if minions = nil then begin
    WriteInt(-1);
    exit;
  end;

  minionCount := Length(minions);
  WriteInt(minionCount);

  for minionIndex := 0 to minionCount - 1 do begin
    WriteMinion(minions[minionIndex]);
  end;
end;

procedure TRemoteProcessClient.WriteMove(move: TMove);
begin
  if move = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteDouble(move.Speed);
  WriteDouble(move.StrafeSpeed);
  WriteDouble(move.Turn);
  WriteEnum(move.Action);
  WriteDouble(move.CastAngle);
  WriteDouble(move.MinCastDistance);
  WriteDouble(move.MaxCastDistance);
  WriteLong(move.StatusTargetId);
  WriteEnum(move.SkillToLearn);
  WriteMessages(move.Messages);
end;

procedure TRemoteProcessClient.WriteMoves(moves: TMoveArray);
var
  moveIndex: LongInt;
  moveCount: LongInt;

begin
  if moves = nil then begin
    WriteInt(-1);
    exit;
  end;

  moveCount := Length(moves);
  WriteInt(moveCount);

  for moveIndex := 0 to moveCount - 1 do begin
    WriteMove(moves[moveIndex]);
  end;
end;

function TRemoteProcessClient.ReadPlayer: TPlayer;
var
  id: Int64;
  me: Boolean;
  name: String;
  strategyCrashed: Boolean;
  score: LongInt;
  faction: TFaction;

begin
  if not ReadBoolean then begin
    result := nil;
    exit;
  end;

  id := ReadLong;
  me := ReadBoolean;
  name := ReadString;
  strategyCrashed := ReadBoolean;
  score := ReadInt;
  faction := ReadEnum;

  result := TPlayer.Create(id, me, name, strategyCrashed, score, faction);
end;

procedure TRemoteProcessClient.WritePlayer(player: TPlayer);
begin
  if player = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteLong(player.GetId);
  WriteBoolean(player.GetMe);
  WriteString(player.GetName);
  WriteBoolean(player.GetStrategyCrashed);
  WriteInt(player.GetScore);
  WriteEnum(player.GetFaction);
end;

function TRemoteProcessClient.ReadPlayers: TPlayerArray;
var
  playerIndex: LongInt;
  playerCount: LongInt;

begin
  playerCount := ReadInt;
  if playerCount < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, playerCount);

  for playerIndex := 0 to playerCount - 1 do begin
    result[playerIndex] := ReadPlayer;
  end;
end;

procedure TRemoteProcessClient.WritePlayers(players: TPlayerArray);
var
  playerIndex: LongInt;
  playerCount: LongInt;

begin
  if players = nil then begin
    WriteInt(-1);
    exit;
  end;

  playerCount := Length(players);
  WriteInt(playerCount);

  for playerIndex := 0 to playerCount - 1 do begin
    WritePlayer(players[playerIndex]);
  end;
end;

function TRemoteProcessClient.ReadPlayerContext: TPlayerContext;
var
  wizards: TWizardArray;
  world: TWorld;

begin
  if not ReadBoolean then begin
    result := nil;
    exit;
  end;

  wizards := ReadWizards;
  world := ReadWorld;

  result := TPlayerContext.Create(wizards, world);
end;

procedure TRemoteProcessClient.WritePlayerContext(playerContext: TPlayerContext);
begin
  if playerContext = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteWizards(playerContext.GetWizards);
  WriteWorld(playerContext.GetWorld);
end;

function TRemoteProcessClient.ReadPlayerContexts: TPlayerContextArray;
var
  playerContextIndex: LongInt;
  playerContextCount: LongInt;

begin
  playerContextCount := ReadInt;
  if playerContextCount < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, playerContextCount);

  for playerContextIndex := 0 to playerContextCount - 1 do begin
    result[playerContextIndex] := ReadPlayerContext;
  end;
end;

procedure TRemoteProcessClient.WritePlayerContexts(playerContexts: TPlayerContextArray);
var
  playerContextIndex: LongInt;
  playerContextCount: LongInt;

begin
  if playerContexts = nil then begin
    WriteInt(-1);
    exit;
  end;

  playerContextCount := Length(playerContexts);
  WriteInt(playerContextCount);

  for playerContextIndex := 0 to playerContextCount - 1 do begin
    WritePlayerContext(playerContexts[playerContextIndex]);
  end;
end;

function TRemoteProcessClient.ReadProjectile: TProjectile;
var
  id: Int64;
  x: Double;
  y: Double;
  speedX: Double;
  speedY: Double;
  angle: Double;
  faction: TFaction;
  radius: Double;
  projectileType: TProjectileType;
  ownerUnitId: Int64;
  ownerPlayerId: Int64;

begin
  if not ReadBoolean then begin
    result := nil;
    exit;
  end;

  id := ReadLong;
  x := ReadDouble;
  y := ReadDouble;
  speedX := ReadDouble;
  speedY := ReadDouble;
  angle := ReadDouble;
  faction := ReadEnum;
  radius := ReadDouble;
  projectileType := ReadEnum;
  ownerUnitId := ReadLong;
  ownerPlayerId := ReadLong;

  result := TProjectile.Create(id, x, y, speedX, speedY, angle, faction, radius, projectileType, ownerUnitId,
    ownerPlayerId);
end;

procedure TRemoteProcessClient.WriteProjectile(projectile: TProjectile);
begin
  if projectile = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteLong(projectile.GetId);
  WriteDouble(projectile.GetX);
  WriteDouble(projectile.GetY);
  WriteDouble(projectile.GetSpeedX);
  WriteDouble(projectile.GetSpeedY);
  WriteDouble(projectile.GetAngle);
  WriteEnum(projectile.GetFaction);
  WriteDouble(projectile.GetRadius);
  WriteEnum(projectile.GetType);
  WriteLong(projectile.GetOwnerUnitId);
  WriteLong(projectile.GetOwnerPlayerId);
end;

function TRemoteProcessClient.ReadProjectiles: TProjectileArray;
var
  projectileIndex: LongInt;
  projectileCount: LongInt;

begin
  projectileCount := ReadInt;
  if projectileCount < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, projectileCount);

  for projectileIndex := 0 to projectileCount - 1 do begin
    result[projectileIndex] := ReadProjectile;
  end;
end;

procedure TRemoteProcessClient.WriteProjectiles(projectiles: TProjectileArray);
var
  projectileIndex: LongInt;
  projectileCount: LongInt;

begin
  if projectiles = nil then begin
    WriteInt(-1);
    exit;
  end;

  projectileCount := Length(projectiles);
  WriteInt(projectileCount);

  for projectileIndex := 0 to projectileCount - 1 do begin
    WriteProjectile(projectiles[projectileIndex]);
  end;
end;

function TRemoteProcessClient.ReadStatus: TStatus;
var
  id: Int64;
  statusType: TStatusType;
  wizardId: Int64;
  playerId: Int64;
  remainingDurationTicks: LongInt;

begin
  if not ReadBoolean then begin
    result := nil;
    exit;
  end;

  id := ReadLong;
  statusType := ReadEnum;
  wizardId := ReadLong;
  playerId := ReadLong;
  remainingDurationTicks := ReadInt;

  result := TStatus.Create(id, statusType, wizardId, playerId, remainingDurationTicks);
end;

procedure TRemoteProcessClient.WriteStatus(status: TStatus);
begin
  if status = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteLong(status.GetId);
  WriteEnum(status.GetType);
  WriteLong(status.GetWizardId);
  WriteLong(status.GetPlayerId);
  WriteInt(status.GetRemainingDurationTicks);
end;

function TRemoteProcessClient.ReadStatuses: TStatusArray;
var
  statusIndex: LongInt;
  statusCount: LongInt;

begin
  statusCount := ReadInt;
  if statusCount < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, statusCount);

  for statusIndex := 0 to statusCount - 1 do begin
    result[statusIndex] := ReadStatus;
  end;
end;

procedure TRemoteProcessClient.WriteStatuses(statuses: TStatusArray);
var
  statusIndex: LongInt;
  statusCount: LongInt;

begin
  if statuses = nil then begin
    WriteInt(-1);
    exit;
  end;

  statusCount := Length(statuses);
  WriteInt(statusCount);

  for statusIndex := 0 to statusCount - 1 do begin
    WriteStatus(statuses[statusIndex]);
  end;
end;

function TRemoteProcessClient.ReadTree: TTree;
var
  id: Int64;
  x: Double;
  y: Double;
  speedX: Double;
  speedY: Double;
  angle: Double;
  faction: TFaction;
  radius: Double;
  life: LongInt;
  maxLife: LongInt;
  statuses: TStatusArray;

begin
  if not ReadBoolean then begin
    result := nil;
    exit;
  end;

  id := ReadLong;
  x := ReadDouble;
  y := ReadDouble;
  speedX := ReadDouble;
  speedY := ReadDouble;
  angle := ReadDouble;
  faction := ReadEnum;
  radius := ReadDouble;
  life := ReadInt;
  maxLife := ReadInt;
  statuses := ReadStatuses;

  result := TTree.Create(id, x, y, speedX, speedY, angle, faction, radius, life, maxLife, statuses);
end;

procedure TRemoteProcessClient.WriteTree(tree: TTree);
begin
  if tree = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteLong(tree.GetId);
  WriteDouble(tree.GetX);
  WriteDouble(tree.GetY);
  WriteDouble(tree.GetSpeedX);
  WriteDouble(tree.GetSpeedY);
  WriteDouble(tree.GetAngle);
  WriteEnum(tree.GetFaction);
  WriteDouble(tree.GetRadius);
  WriteInt(tree.GetLife);
  WriteInt(tree.GetMaxLife);
  WriteStatuses(tree.GetStatuses);
end;

function TRemoteProcessClient.ReadTrees: TTreeArray;
var
  treeIndex: LongInt;
  treeCount: LongInt;

begin
  treeCount := ReadInt;
  if treeCount < 0 then begin
    result := FPreviousTrees;
    exit;
  end;

  if Assigned(FPreviousTrees) then begin
    for treeIndex := High(FPreviousTrees) downto 0 do begin
      if Assigned(FPreviousTrees[treeIndex]) then begin
        FPreviousTrees[treeIndex].Free;
      end;
    end;
  end;

  SetLength(FPreviousTrees, treeCount);

  for treeIndex := 0 to treeCount - 1 do begin
    FPreviousTrees[treeIndex] := ReadTree;
  end;

  result := FPreviousTrees;
end;

procedure TRemoteProcessClient.WriteTrees(trees: TTreeArray);
var
  treeIndex: LongInt;
  treeCount: LongInt;

begin
  if trees = nil then begin
    WriteInt(-1);
    exit;
  end;

  treeCount := Length(trees);
  WriteInt(treeCount);

  for treeIndex := 0 to treeCount - 1 do begin
    WriteTree(trees[treeIndex]);
  end;
end;

function TRemoteProcessClient.ReadWizard: TWizard;
var
  id: Int64;
  x: Double;
  y: Double;
  speedX: Double;
  speedY: Double;
  angle: Double;
  faction: TFaction;
  radius: Double;
  life: LongInt;
  maxLife: LongInt;
  statuses: TStatusArray;
  ownerPlayerId: Int64;
  me: Boolean;
  mana: LongInt;
  maxMana: LongInt;
  visionRange: Double;
  castRange: Double;
  xp: LongInt;
  level: LongInt;
  skills: TSkillTypeArray;
  remainingActionCooldownTicks: LongInt;
  remainingCooldownTicksByAction: TLongIntArray;
  master: Boolean;
  messages: TMessageArray;

begin
  if not ReadBoolean then begin
    result := nil;
    exit;
  end;

  id := ReadLong;
  x := ReadDouble;
  y := ReadDouble;
  speedX := ReadDouble;
  speedY := ReadDouble;
  angle := ReadDouble;
  faction := ReadEnum;
  radius := ReadDouble;
  life := ReadInt;
  maxLife := ReadInt;
  statuses := ReadStatuses;
  ownerPlayerId := ReadLong;
  me := ReadBoolean;
  mana := ReadInt;
  maxMana := ReadInt;
  visionRange := ReadDouble;
  castRange := ReadDouble;
  xp := ReadInt;
  level := ReadInt;
  skills := ReadEnumArray;
  remainingActionCooldownTicks := ReadInt;
  remainingCooldownTicksByAction := ReadIntArray;
  master := ReadBoolean;
  messages := ReadMessages;

  result := TWizard.Create(id, x, y, speedX, speedY, angle, faction, radius, life, maxLife, statuses, ownerPlayerId, me,
    mana, maxMana, visionRange, castRange, xp, level, skills, remainingActionCooldownTicks,
    remainingCooldownTicksByAction, master, messages);
end;

procedure TRemoteProcessClient.WriteWizard(wizard: TWizard);
begin
  if wizard = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteLong(wizard.GetId);
  WriteDouble(wizard.GetX);
  WriteDouble(wizard.GetY);
  WriteDouble(wizard.GetSpeedX);
  WriteDouble(wizard.GetSpeedY);
  WriteDouble(wizard.GetAngle);
  WriteEnum(wizard.GetFaction);
  WriteDouble(wizard.GetRadius);
  WriteInt(wizard.GetLife);
  WriteInt(wizard.GetMaxLife);
  WriteStatuses(wizard.GetStatuses);
  WriteLong(wizard.GetOwnerPlayerId);
  WriteBoolean(wizard.GetMe);
  WriteInt(wizard.GetMana);
  WriteInt(wizard.GetMaxMana);
  WriteDouble(wizard.GetVisionRange);
  WriteDouble(wizard.GetCastRange);
  WriteInt(wizard.GetXp);
  WriteInt(wizard.GetLevel);
  WriteEnumArray(wizard.GetSkills);
  WriteInt(wizard.GetRemainingActionCooldownTicks);
  WriteIntArray(wizard.GetRemainingCooldownTicksByAction);
  WriteBoolean(wizard.GetMaster);
  WriteMessages(wizard.GetMessages);
end;

function TRemoteProcessClient.ReadWizards: TWizardArray;
var
  wizardIndex: LongInt;
  wizardCount: LongInt;

begin
  wizardCount := ReadInt;
  if wizardCount < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, wizardCount);

  for wizardIndex := 0 to wizardCount - 1 do begin
    result[wizardIndex] := ReadWizard;
  end;
end;

procedure TRemoteProcessClient.WriteWizards(wizards: TWizardArray);
var
  wizardIndex: LongInt;
  wizardCount: LongInt;

begin
  if wizards = nil then begin
    WriteInt(-1);
    exit;
  end;

  wizardCount := Length(wizards);
  WriteInt(wizardCount);

  for wizardIndex := 0 to wizardCount - 1 do begin
    WriteWizard(wizards[wizardIndex]);
  end;
end;

function TRemoteProcessClient.ReadWorld: TWorld;
var
  tickIndex: LongInt;
  tickCount: LongInt;
  width: Double;
  height: Double;
  players: TPlayerArray;
  wizards: TWizardArray;
  minions: TMinionArray;
  projectiles: TProjectileArray;
  bonuses: TBonusArray;
  buildings: TBuildingArray;
  trees: TTreeArray;

begin
  if not ReadBoolean then begin
    result := nil;
    exit;
  end;

  tickIndex := ReadInt;
  tickCount := ReadInt;
  width := ReadDouble;
  height := ReadDouble;
  players := ReadPlayers;
  wizards := ReadWizards;
  minions := ReadMinions;
  projectiles := ReadProjectiles;
  bonuses := ReadBonuses;
  buildings := ReadBuildings;
  trees := ReadTrees;

  result := TWorld.Create(tickIndex, tickCount, width, height, players, wizards, minions, projectiles, bonuses,
    buildings, trees);
end;

procedure TRemoteProcessClient.WriteWorld(world: TWorld);
begin
  if world = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteInt(world.GetTickIndex);
  WriteInt(world.GetTickCount);
  WriteDouble(world.GetWidth);
  WriteDouble(world.GetHeight);
  WritePlayers(world.GetPlayers);
  WriteWizards(world.GetWizards);
  WriteMinions(world.GetMinions);
  WriteProjectiles(world.GetProjectiles);
  WriteBonuses(world.GetBonuses);
  WriteBuildings(world.GetBuildings);
  WriteTrees(world.GetTrees);
end;

function TRemoteProcessClient.ReadWorlds: TWorldArray;
var
  worldIndex: LongInt;
  worldCount: LongInt;

begin
  worldCount := ReadInt;
  if worldCount < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, worldCount);

  for worldIndex := 0 to worldCount - 1 do begin
    result[worldIndex] := ReadWorld;
  end;
end;

procedure TRemoteProcessClient.WriteWorlds(worlds: TWorldArray);
var
  worldIndex: LongInt;
  worldCount: LongInt;

begin
  if worlds = nil then begin
    WriteInt(-1);
    exit;
  end;

  worldCount := Length(worlds);
  WriteInt(worldCount);

  for worldIndex := 0 to worldCount - 1 do begin
    WriteWorld(worlds[worldIndex]);
  end;
end;

function TRemoteProcessClient.ReadByteArray(nullable: Boolean): TByteArray;
var
  len: LongInt;

begin
  len := ReadInt;

  if nullable then begin
    if len < 0 then begin
      result := nil;
      exit;
    end;
  end else begin
    if len <= 0 then begin
      SetLength(result, 0);
      exit;
    end;
  end;

  result := ReadBytes(len);
end;

procedure TRemoteProcessClient.WriteByteArray(value: TByteArray);
begin
  if value = nil then begin
    WriteInt(-1);
    exit;
  end;

  WriteInt(Length(value));
  WriteBytes(value);
end;

procedure TRemoteProcessClient.WriteEnum(value: LongInt);
var
  bytes: TByteArray;

begin
  SetLength(bytes, 1);
  bytes[0] := value;
  WriteBytes(bytes);
  Finalize(bytes);
end;

procedure TRemoteProcessClient.WriteEnumArray(value: TLongIntArray);
var
  i, len: LongInt;

begin
  if value = nil then begin
    WriteInt(-1);
    exit;
  end;

  len := Length(value);
  WriteInt(len);

  for i := 0 to len - 1 do begin
    WriteEnum(value[i]);
  end;
end;

procedure TRemoteProcessClient.WriteEnumArray2D(value: TLongIntArray2D);
var
  i, len: LongInt;

begin
  if value = nil then begin
    WriteInt(-1);
    exit;
  end;

  len := Length(value);
  WriteInt(len);

  for i := 0 to len - 1 do begin
    WriteEnumArray(value[i]);
  end;
end;

function TRemoteProcessClient.ReadEnum: TMessageType;
var
  bytes: TByteArray;

begin
  bytes := ReadBytes(1);
  result := bytes[0];
  Finalize(bytes);
end;

function TRemoteProcessClient.ReadEnumArray: TLongIntArray;
var
  i, len: LongInt;

begin
  len := ReadInt;
  if len < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, len);

  for i := 0 to len - 1 do begin
    result[i] := ReadEnum;
  end;
end;

function TRemoteProcessClient.ReadEnumArray2D: TLongIntArray2D;
var
  i, len: LongInt;

begin
  len := ReadInt;
  if len < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, len);

  for i := 0 to len - 1 do begin
    result[i] := ReadEnumArray;
  end;
end;

procedure TRemoteProcessClient.WriteBytes(bytes: TByteArray);
begin
  FSocket.StrictSend(bytes, Length(bytes));
end;

function TRemoteProcessClient.ReadBytes(byteCount: LongInt): TByteArray;
var
  bytes: TByteArray;

begin
  SetLength(bytes, byteCount);
  FSocket.StrictReceive(bytes, byteCount);
  result := bytes;
end;

procedure TRemoteProcessClient.WriteString(value: String);
var
  len, i: LongInt;
  bytes: TByteArray;
  AnsiValue: AnsiString;

begin
  AnsiValue := AnsiString(value);

  len := Length(AnsiValue);
  SetLength(bytes, len);
  for i := 1 to len do begin
    bytes[i - 1] := Ord(AnsiValue[i]);
  end;

  WriteInt(len);
  WriteBytes(bytes);
  Finalize(bytes);
end;

procedure TRemoteProcessClient.WriteBoolean(value: Boolean);
var
  bytes: TByteArray;

begin
  SetLength(bytes, 1);
  bytes[0] := ord(value);
  WriteBytes(bytes);
  Finalize(bytes);
end;

function TRemoteProcessClient.ReadBoolean: Boolean;
var
  bytes: TByteArray;

begin
  bytes := ReadBytes(1);
  result := (bytes[0] <> 0);
  Finalize(bytes);
end;

function TRemoteProcessClient.ReadString: String;
var
  len, i: LongInt;
  bytes: TByteArray;
  res: AnsiString;

begin
  len := ReadInt;
  if len = -1 then begin
    HALT(10014);
  end;

  res := '';
  bytes := ReadBytes(len);
  for i := 0 to len - 1 do begin
    res := res + AnsiChar(bytes[i]);
  end;
    
  Finalize(bytes);
  result := string(res);
end;

procedure TRemoteProcessClient.WriteDouble(value: Double);
var
  pl: ^Int64;
  pd: ^Double;
  p: Pointer;

begin
  New(pd);
  pd^ := value;
  p := pd;
  pl := p;
  WriteLong(pl^);
  Dispose(pd);
end;

function TRemoteProcessClient.ReadDouble: Double;
var
  pl: ^Int64;
  pd: ^Double;
  p: Pointer;
    
begin
  New(pl);
  pl^ := ReadLong;
  p := pl;
  pd := p;
  result := pd^;
  Dispose(pl);
end;

procedure TRemoteProcessClient.WriteInt(value: LongInt);
var
  bytes: TByteArray;
  i: LongInt;
    
begin
  SetLength(bytes, INTEGER_SIZE_BYTES);
  for i := 0 to INTEGER_SIZE_BYTES - 1 do begin
    bytes[i] := (value shr ({24 -} i * 8)) and 255;
  end;

  if (IsLittleEndianMachine <> LITTLE_ENDIAN_BYTE_ORDER) then begin
    Reverse(bytes);
  end;

  WriteBytes(bytes);
  Finalize(bytes);
end;

procedure TRemoteProcessClient.WriteIntArray(value: TLongIntArray);
var
  i, len: LongInt;

begin
  if value = nil then begin
    WriteInt(-1);
    exit;
  end;

  len := Length(value);
  WriteInt(len);

  for i := 0 to len - 1 do begin
    WriteInt(value[i]);
  end;
end;

procedure TRemoteProcessClient.WriteIntArray2D(value: TLongIntArray2D);
var
  i, len: LongInt;

begin
  if value = nil then begin
    WriteInt(-1);
    exit;
  end;

  len := Length(value);
  WriteInt(len);

  for i := 0 to len - 1 do begin
    WriteIntArray(value[i]);
  end;
end;

function TRemoteProcessClient.ReadInt: LongInt;
var
  bytes: TByteArray;
  res: LongInt;
  i: LongInt;
    
begin
  res := 0;
  bytes := readBytes(INTEGER_SIZE_BYTES);
  for i := INTEGER_SIZE_BYTES - 1 downto 0 do begin
    res := (res shl 8) or bytes[i];
  end;
        
  Finalize(bytes);
  result := res;
end;

function TRemoteProcessClient.ReadIntArray: TLongIntArray;
var
  i, len: LongInt;

begin
  len := ReadInt;
  if len < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, len);

  for i := 0 to len - 1 do begin
    result[i] := ReadInt;
  end;
end;

function TRemoteProcessClient.ReadIntArray2D: TLongIntArray2D;
var
  i, len: LongInt;

begin
  len := ReadInt;
  if len < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, len);

  for i := 0 to len - 1 do begin
    result[i] := ReadIntArray;
  end;
end;

function TRemoteProcessClient.ReadLong: Int64;
var
  bytes: TByteArray;
  res: Int64;
  i: LongInt;
    
begin
  res := 0;
  bytes := readBytes(LONG_SIZE_BYTES);
  for i := LONG_SIZE_BYTES - 1 downto 0 do begin
    res := (res shl 8) or bytes[i];
  end;
        
  Finalize(bytes);
  result := res;
end;

procedure TRemoteProcessClient.WriteLong(value: Int64);
var
  bytes: TByteArray;
  i: LongInt;
    
begin
  SetLength(bytes, LONG_SIZE_BYTES);
  for i := 0 to LONG_SIZE_BYTES - 1 do begin
    bytes[i] := (value shr ({24 -} i*8)) and 255;
  end;

  if (IsLittleEndianMachine <> LITTLE_ENDIAN_BYTE_ORDER) then begin
    Reverse(bytes);
  end;

  WriteBytes(bytes);
  Finalize(bytes);
end;

function TRemoteProcessClient.IsLittleEndianMachine: Boolean;
begin
  result := true;
end;

procedure TRemoteProcessClient.Reverse(var bytes: TByteArray);
var
  i, len: LongInt;
  buffer: Byte;

begin
  len := Length(bytes);
  for i := 0 to (len div 2) do begin
    buffer := bytes[i];
    bytes[i] := bytes[len - i - 1];
    bytes[len - i - 1] := buffer;
  end;
end;

destructor TRemoteProcessClient.Destroy;
var
  treeIndex: LongInt;

begin
  FSocket.Free;

  if Assigned(FPreviousTrees) then begin
    for treeIndex := High(FPreviousTrees) downto 0 do begin
      if Assigned(FPreviousTrees[treeIndex]) then begin
        FPreviousTrees[treeIndex].Free;
      end;
    end;
  end;
end;

end.
