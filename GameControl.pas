unit GameControl;

interface

uses
  Math, TypeControl;

type
  TGame = class
  private
    FRandomSeed: Int64;
    FTickCount: LongInt;
    FMapSize: Double;
    FSkillsEnabled: Boolean;
    FRawMessagesEnabled: Boolean;
    FFriendlyFireDamageFactor: Double;
    FBuildingDamageScoreFactor: Double;
    FBuildingEliminationScoreFactor: Double;
    FMinionDamageScoreFactor: Double;
    FMinionEliminationScoreFactor: Double;
    FWizardDamageScoreFactor: Double;
    FWizardEliminationScoreFactor: Double;
    FTeamWorkingScoreFactor: Double;
    FVictoryScore: LongInt;
    FScoreGainRange: Double;
    FRawMessageMaxLength: LongInt;
    FRawMessageTransmissionSpeed: Double;
    FWizardRadius: Double;
    FWizardCastRange: Double;
    FWizardVisionRange: Double;
    FWizardForwardSpeed: Double;
    FWizardBackwardSpeed: Double;
    FWizardStrafeSpeed: Double;
    FWizardBaseLife: LongInt;
    FWizardLifeGrowthPerLevel: LongInt;
    FWizardBaseMana: LongInt;
    FWizardManaGrowthPerLevel: LongInt;
    FWizardBaseLifeRegeneration: Double;
    FWizardLifeRegenerationGrowthPerLevel: Double;
    FWizardBaseManaRegeneration: Double;
    FWizardManaRegenerationGrowthPerLevel: Double;
    FWizardMaxTurnAngle: Double;
    FWizardMaxResurrectionDelayTicks: LongInt;
    FWizardMinResurrectionDelayTicks: LongInt;
    FWizardActionCooldownTicks: LongInt;
    FStaffCooldownTicks: LongInt;
    FMagicMissileCooldownTicks: LongInt;
    FFrostBoltCooldownTicks: LongInt;
    FFireballCooldownTicks: LongInt;
    FHasteCooldownTicks: LongInt;
    FShieldCooldownTicks: LongInt;
    FMagicMissileManacost: LongInt;
    FFrostBoltManacost: LongInt;
    FFireballManacost: LongInt;
    FHasteManacost: LongInt;
    FShieldManacost: LongInt;
    FStaffDamage: LongInt;
    FStaffSector: Double;
    FStaffRange: Double;
    FLevelUpXpValues: TLongIntArray;
    FMinionRadius: Double;
    FMinionVisionRange: Double;
    FMinionSpeed: Double;
    FMinionMaxTurnAngle: Double;
    FMinionLife: LongInt;
    FFactionMinionAppearanceIntervalTicks: LongInt;
    FOrcWoodcutterActionCooldownTicks: LongInt;
    FOrcWoodcutterDamage: LongInt;
    FOrcWoodcutterAttackSector: Double;
    FOrcWoodcutterAttackRange: Double;
    FFetishBlowdartActionCooldownTicks: LongInt;
    FFetishBlowdartAttackRange: Double;
    FFetishBlowdartAttackSector: Double;
    FBonusRadius: Double;
    FBonusAppearanceIntervalTicks: LongInt;
    FBonusScoreAmount: LongInt;
    FDartRadius: Double;
    FDartSpeed: Double;
    FDartDirectDamage: LongInt;
    FMagicMissileRadius: Double;
    FMagicMissileSpeed: Double;
    FMagicMissileDirectDamage: LongInt;
    FFrostBoltRadius: Double;
    FFrostBoltSpeed: Double;
    FFrostBoltDirectDamage: LongInt;
    FFireballRadius: Double;
    FFireballSpeed: Double;
    FFireballExplosionMaxDamageRange: Double;
    FFireballExplosionMinDamageRange: Double;
    FFireballExplosionMaxDamage: LongInt;
    FFireballExplosionMinDamage: LongInt;
    FGuardianTowerRadius: Double;
    FGuardianTowerVisionRange: Double;
    FGuardianTowerLife: Double;
    FGuardianTowerAttackRange: Double;
    FGuardianTowerDamage: LongInt;
    FGuardianTowerCooldownTicks: LongInt;
    FFactionBaseRadius: Double;
    FFactionBaseVisionRange: Double;
    FFactionBaseLife: Double;
    FFactionBaseAttackRange: Double;
    FFactionBaseDamage: LongInt;
    FFactionBaseCooldownTicks: LongInt;
    FBurningDurationTicks: LongInt;
    FBurningSummaryDamage: LongInt;
    FEmpoweredDurationTicks: LongInt;
    FEmpoweredDamageFactor: Double;
    FFrozenDurationTicks: LongInt;
    FHastenedDurationTicks: LongInt;
    FHastenedBonusDurationFactor: Double;
    FHastenedMovementBonusFactor: Double;
    FHastenedRotationBonusFactor: Double;
    FShieldedDurationTicks: LongInt;
    FShieldedBonusDurationFactor: Double;
    FShieldedDirectDamageAbsorptionFactor: Double;
    FAuraSkillRange: Double;
    FRangeBonusPerSkillLevel: Double;
    FMagicalDamageBonusPerSkillLevel: LongInt;
    FStaffDamageBonusPerSkillLevel: LongInt;
    FMovementBonusFactorPerSkillLevel: Double;
    FMagicalDamageAbsorptionPerSkillLevel: LongInt;

  public
    constructor Create(const randomSeed: Int64; const tickCount: LongInt; const mapSize: Double;
      const skillsEnabled: Boolean; const rawMessagesEnabled: Boolean; const friendlyFireDamageFactor: Double;
      const buildingDamageScoreFactor: Double; const buildingEliminationScoreFactor: Double;
      const minionDamageScoreFactor: Double; const minionEliminationScoreFactor: Double;
      const wizardDamageScoreFactor: Double; const wizardEliminationScoreFactor: Double;
      const teamWorkingScoreFactor: Double; const victoryScore: LongInt; const scoreGainRange: Double;
      const rawMessageMaxLength: LongInt; const rawMessageTransmissionSpeed: Double; const wizardRadius: Double;
      const wizardCastRange: Double; const wizardVisionRange: Double; const wizardForwardSpeed: Double;
      const wizardBackwardSpeed: Double; const wizardStrafeSpeed: Double; const wizardBaseLife: LongInt;
      const wizardLifeGrowthPerLevel: LongInt; const wizardBaseMana: LongInt; const wizardManaGrowthPerLevel: LongInt;
      const wizardBaseLifeRegeneration: Double; const wizardLifeRegenerationGrowthPerLevel: Double;
      const wizardBaseManaRegeneration: Double; const wizardManaRegenerationGrowthPerLevel: Double;
      const wizardMaxTurnAngle: Double; const wizardMaxResurrectionDelayTicks: LongInt;
      const wizardMinResurrectionDelayTicks: LongInt; const wizardActionCooldownTicks: LongInt;
      const staffCooldownTicks: LongInt; const magicMissileCooldownTicks: LongInt;
      const frostBoltCooldownTicks: LongInt; const fireballCooldownTicks: LongInt; const hasteCooldownTicks: LongInt;
      const shieldCooldownTicks: LongInt; const magicMissileManacost: LongInt; const frostBoltManacost: LongInt;
      const fireballManacost: LongInt; const hasteManacost: LongInt; const shieldManacost: LongInt;
      const staffDamage: LongInt; const staffSector: Double; const staffRange: Double;
      const levelUpXpValues: TLongIntArray; const minionRadius: Double; const minionVisionRange: Double;
      const minionSpeed: Double; const minionMaxTurnAngle: Double; const minionLife: LongInt;
      const factionMinionAppearanceIntervalTicks: LongInt; const orcWoodcutterActionCooldownTicks: LongInt;
      const orcWoodcutterDamage: LongInt; const orcWoodcutterAttackSector: Double;
      const orcWoodcutterAttackRange: Double; const fetishBlowdartActionCooldownTicks: LongInt;
      const fetishBlowdartAttackRange: Double; const fetishBlowdartAttackSector: Double; const bonusRadius: Double;
      const bonusAppearanceIntervalTicks: LongInt; const bonusScoreAmount: LongInt; const dartRadius: Double;
      const dartSpeed: Double; const dartDirectDamage: LongInt; const magicMissileRadius: Double;
      const magicMissileSpeed: Double; const magicMissileDirectDamage: LongInt; const frostBoltRadius: Double;
      const frostBoltSpeed: Double; const frostBoltDirectDamage: LongInt; const fireballRadius: Double;
      const fireballSpeed: Double; const fireballExplosionMaxDamageRange: Double;
      const fireballExplosionMinDamageRange: Double; const fireballExplosionMaxDamage: LongInt;
      const fireballExplosionMinDamage: LongInt; const guardianTowerRadius: Double;
      const guardianTowerVisionRange: Double; const guardianTowerLife: Double; const guardianTowerAttackRange: Double;
      const guardianTowerDamage: LongInt; const guardianTowerCooldownTicks: LongInt; const factionBaseRadius: Double;
      const factionBaseVisionRange: Double; const factionBaseLife: Double; const factionBaseAttackRange: Double;
      const factionBaseDamage: LongInt; const factionBaseCooldownTicks: LongInt; const burningDurationTicks: LongInt;
      const burningSummaryDamage: LongInt; const empoweredDurationTicks: LongInt; const empoweredDamageFactor: Double;
      const frozenDurationTicks: LongInt; const hastenedDurationTicks: LongInt;
      const hastenedBonusDurationFactor: Double; const hastenedMovementBonusFactor: Double;
      const hastenedRotationBonusFactor: Double; const shieldedDurationTicks: LongInt;
      const shieldedBonusDurationFactor: Double; const shieldedDirectDamageAbsorptionFactor: Double;
      const auraSkillRange: Double; const rangeBonusPerSkillLevel: Double;
      const magicalDamageBonusPerSkillLevel: LongInt; const staffDamageBonusPerSkillLevel: LongInt;
      const movementBonusFactorPerSkillLevel: Double; const magicalDamageAbsorptionPerSkillLevel: LongInt);

    function GetRandomSeed: Int64;
    property RandomSeed: Int64 read GetRandomSeed;
    function GetTickCount: LongInt;
    property TickCount: LongInt read GetTickCount;
    function GetMapSize: Double;
    property MapSize: Double read GetMapSize;
    function GetSkillsEnabled: Boolean;
    property IsSkillsEnabled: Boolean read GetSkillsEnabled;
    function GetRawMessagesEnabled: Boolean;
    property IsRawMessagesEnabled: Boolean read GetRawMessagesEnabled;
    function GetFriendlyFireDamageFactor: Double;
    property FriendlyFireDamageFactor: Double read GetFriendlyFireDamageFactor;
    function GetBuildingDamageScoreFactor: Double;
    property BuildingDamageScoreFactor: Double read GetBuildingDamageScoreFactor;
    function GetBuildingEliminationScoreFactor: Double;
    property BuildingEliminationScoreFactor: Double read GetBuildingEliminationScoreFactor;
    function GetMinionDamageScoreFactor: Double;
    property MinionDamageScoreFactor: Double read GetMinionDamageScoreFactor;
    function GetMinionEliminationScoreFactor: Double;
    property MinionEliminationScoreFactor: Double read GetMinionEliminationScoreFactor;
    function GetWizardDamageScoreFactor: Double;
    property WizardDamageScoreFactor: Double read GetWizardDamageScoreFactor;
    function GetWizardEliminationScoreFactor: Double;
    property WizardEliminationScoreFactor: Double read GetWizardEliminationScoreFactor;
    function GetTeamWorkingScoreFactor: Double;
    property TeamWorkingScoreFactor: Double read GetTeamWorkingScoreFactor;
    function GetVictoryScore: LongInt;
    property VictoryScore: LongInt read GetVictoryScore;
    function GetScoreGainRange: Double;
    property ScoreGainRange: Double read GetScoreGainRange;
    function GetRawMessageMaxLength: LongInt;
    property RawMessageMaxLength: LongInt read GetRawMessageMaxLength;
    function GetRawMessageTransmissionSpeed: Double;
    property RawMessageTransmissionSpeed: Double read GetRawMessageTransmissionSpeed;
    function GetWizardRadius: Double;
    property WizardRadius: Double read GetWizardRadius;
    function GetWizardCastRange: Double;
    property WizardCastRange: Double read GetWizardCastRange;
    function GetWizardVisionRange: Double;
    property WizardVisionRange: Double read GetWizardVisionRange;
    function GetWizardForwardSpeed: Double;
    property WizardForwardSpeed: Double read GetWizardForwardSpeed;
    function GetWizardBackwardSpeed: Double;
    property WizardBackwardSpeed: Double read GetWizardBackwardSpeed;
    function GetWizardStrafeSpeed: Double;
    property WizardStrafeSpeed: Double read GetWizardStrafeSpeed;
    function GetWizardBaseLife: LongInt;
    property WizardBaseLife: LongInt read GetWizardBaseLife;
    function GetWizardLifeGrowthPerLevel: LongInt;
    property WizardLifeGrowthPerLevel: LongInt read GetWizardLifeGrowthPerLevel;
    function GetWizardBaseMana: LongInt;
    property WizardBaseMana: LongInt read GetWizardBaseMana;
    function GetWizardManaGrowthPerLevel: LongInt;
    property WizardManaGrowthPerLevel: LongInt read GetWizardManaGrowthPerLevel;
    function GetWizardBaseLifeRegeneration: Double;
    property WizardBaseLifeRegeneration: Double read GetWizardBaseLifeRegeneration;
    function GetWizardLifeRegenerationGrowthPerLevel: Double;
    property WizardLifeRegenerationGrowthPerLevel: Double read GetWizardLifeRegenerationGrowthPerLevel;
    function GetWizardBaseManaRegeneration: Double;
    property WizardBaseManaRegeneration: Double read GetWizardBaseManaRegeneration;
    function GetWizardManaRegenerationGrowthPerLevel: Double;
    property WizardManaRegenerationGrowthPerLevel: Double read GetWizardManaRegenerationGrowthPerLevel;
    function GetWizardMaxTurnAngle: Double;
    property WizardMaxTurnAngle: Double read GetWizardMaxTurnAngle;
    function GetWizardMaxResurrectionDelayTicks: LongInt;
    property WizardMaxResurrectionDelayTicks: LongInt read GetWizardMaxResurrectionDelayTicks;
    function GetWizardMinResurrectionDelayTicks: LongInt;
    property WizardMinResurrectionDelayTicks: LongInt read GetWizardMinResurrectionDelayTicks;
    function GetWizardActionCooldownTicks: LongInt;
    property WizardActionCooldownTicks: LongInt read GetWizardActionCooldownTicks;
    function GetStaffCooldownTicks: LongInt;
    property StaffCooldownTicks: LongInt read GetStaffCooldownTicks;
    function GetMagicMissileCooldownTicks: LongInt;
    property MagicMissileCooldownTicks: LongInt read GetMagicMissileCooldownTicks;
    function GetFrostBoltCooldownTicks: LongInt;
    property FrostBoltCooldownTicks: LongInt read GetFrostBoltCooldownTicks;
    function GetFireballCooldownTicks: LongInt;
    property FireballCooldownTicks: LongInt read GetFireballCooldownTicks;
    function GetHasteCooldownTicks: LongInt;
    property HasteCooldownTicks: LongInt read GetHasteCooldownTicks;
    function GetShieldCooldownTicks: LongInt;
    property ShieldCooldownTicks: LongInt read GetShieldCooldownTicks;
    function GetMagicMissileManacost: LongInt;
    property MagicMissileManacost: LongInt read GetMagicMissileManacost;
    function GetFrostBoltManacost: LongInt;
    property FrostBoltManacost: LongInt read GetFrostBoltManacost;
    function GetFireballManacost: LongInt;
    property FireballManacost: LongInt read GetFireballManacost;
    function GetHasteManacost: LongInt;
    property HasteManacost: LongInt read GetHasteManacost;
    function GetShieldManacost: LongInt;
    property ShieldManacost: LongInt read GetShieldManacost;
    function GetStaffDamage: LongInt;
    property StaffDamage: LongInt read GetStaffDamage;
    function GetStaffSector: Double;
    property StaffSector: Double read GetStaffSector;
    function GetStaffRange: Double;
    property StaffRange: Double read GetStaffRange;
    function GetLevelUpXpValues: TLongIntArray;
    property LevelUpXpValues: TLongIntArray read GetLevelUpXpValues;
    function GetMinionRadius: Double;
    property MinionRadius: Double read GetMinionRadius;
    function GetMinionVisionRange: Double;
    property MinionVisionRange: Double read GetMinionVisionRange;
    function GetMinionSpeed: Double;
    property MinionSpeed: Double read GetMinionSpeed;
    function GetMinionMaxTurnAngle: Double;
    property MinionMaxTurnAngle: Double read GetMinionMaxTurnAngle;
    function GetMinionLife: LongInt;
    property MinionLife: LongInt read GetMinionLife;
    function GetFactionMinionAppearanceIntervalTicks: LongInt;
    property FactionMinionAppearanceIntervalTicks: LongInt read GetFactionMinionAppearanceIntervalTicks;
    function GetOrcWoodcutterActionCooldownTicks: LongInt;
    property OrcWoodcutterActionCooldownTicks: LongInt read GetOrcWoodcutterActionCooldownTicks;
    function GetOrcWoodcutterDamage: LongInt;
    property OrcWoodcutterDamage: LongInt read GetOrcWoodcutterDamage;
    function GetOrcWoodcutterAttackSector: Double;
    property OrcWoodcutterAttackSector: Double read GetOrcWoodcutterAttackSector;
    function GetOrcWoodcutterAttackRange: Double;
    property OrcWoodcutterAttackRange: Double read GetOrcWoodcutterAttackRange;
    function GetFetishBlowdartActionCooldownTicks: LongInt;
    property FetishBlowdartActionCooldownTicks: LongInt read GetFetishBlowdartActionCooldownTicks;
    function GetFetishBlowdartAttackRange: Double;
    property FetishBlowdartAttackRange: Double read GetFetishBlowdartAttackRange;
    function GetFetishBlowdartAttackSector: Double;
    property FetishBlowdartAttackSector: Double read GetFetishBlowdartAttackSector;
    function GetBonusRadius: Double;
    property BonusRadius: Double read GetBonusRadius;
    function GetBonusAppearanceIntervalTicks: LongInt;
    property BonusAppearanceIntervalTicks: LongInt read GetBonusAppearanceIntervalTicks;
    function GetBonusScoreAmount: LongInt;
    property BonusScoreAmount: LongInt read GetBonusScoreAmount;
    function GetDartRadius: Double;
    property DartRadius: Double read GetDartRadius;
    function GetDartSpeed: Double;
    property DartSpeed: Double read GetDartSpeed;
    function GetDartDirectDamage: LongInt;
    property DartDirectDamage: LongInt read GetDartDirectDamage;
    function GetMagicMissileRadius: Double;
    property MagicMissileRadius: Double read GetMagicMissileRadius;
    function GetMagicMissileSpeed: Double;
    property MagicMissileSpeed: Double read GetMagicMissileSpeed;
    function GetMagicMissileDirectDamage: LongInt;
    property MagicMissileDirectDamage: LongInt read GetMagicMissileDirectDamage;
    function GetFrostBoltRadius: Double;
    property FrostBoltRadius: Double read GetFrostBoltRadius;
    function GetFrostBoltSpeed: Double;
    property FrostBoltSpeed: Double read GetFrostBoltSpeed;
    function GetFrostBoltDirectDamage: LongInt;
    property FrostBoltDirectDamage: LongInt read GetFrostBoltDirectDamage;
    function GetFireballRadius: Double;
    property FireballRadius: Double read GetFireballRadius;
    function GetFireballSpeed: Double;
    property FireballSpeed: Double read GetFireballSpeed;
    function GetFireballExplosionMaxDamageRange: Double;
    property FireballExplosionMaxDamageRange: Double read GetFireballExplosionMaxDamageRange;
    function GetFireballExplosionMinDamageRange: Double;
    property FireballExplosionMinDamageRange: Double read GetFireballExplosionMinDamageRange;
    function GetFireballExplosionMaxDamage: LongInt;
    property FireballExplosionMaxDamage: LongInt read GetFireballExplosionMaxDamage;
    function GetFireballExplosionMinDamage: LongInt;
    property FireballExplosionMinDamage: LongInt read GetFireballExplosionMinDamage;
    function GetGuardianTowerRadius: Double;
    property GuardianTowerRadius: Double read GetGuardianTowerRadius;
    function GetGuardianTowerVisionRange: Double;
    property GuardianTowerVisionRange: Double read GetGuardianTowerVisionRange;
    function GetGuardianTowerLife: Double;
    property GuardianTowerLife: Double read GetGuardianTowerLife;
    function GetGuardianTowerAttackRange: Double;
    property GuardianTowerAttackRange: Double read GetGuardianTowerAttackRange;
    function GetGuardianTowerDamage: LongInt;
    property GuardianTowerDamage: LongInt read GetGuardianTowerDamage;
    function GetGuardianTowerCooldownTicks: LongInt;
    property GuardianTowerCooldownTicks: LongInt read GetGuardianTowerCooldownTicks;
    function GetFactionBaseRadius: Double;
    property FactionBaseRadius: Double read GetFactionBaseRadius;
    function GetFactionBaseVisionRange: Double;
    property FactionBaseVisionRange: Double read GetFactionBaseVisionRange;
    function GetFactionBaseLife: Double;
    property FactionBaseLife: Double read GetFactionBaseLife;
    function GetFactionBaseAttackRange: Double;
    property FactionBaseAttackRange: Double read GetFactionBaseAttackRange;
    function GetFactionBaseDamage: LongInt;
    property FactionBaseDamage: LongInt read GetFactionBaseDamage;
    function GetFactionBaseCooldownTicks: LongInt;
    property FactionBaseCooldownTicks: LongInt read GetFactionBaseCooldownTicks;
    function GetBurningDurationTicks: LongInt;
    property BurningDurationTicks: LongInt read GetBurningDurationTicks;
    function GetBurningSummaryDamage: LongInt;
    property BurningSummaryDamage: LongInt read GetBurningSummaryDamage;
    function GetEmpoweredDurationTicks: LongInt;
    property EmpoweredDurationTicks: LongInt read GetEmpoweredDurationTicks;
    function GetEmpoweredDamageFactor: Double;
    property EmpoweredDamageFactor: Double read GetEmpoweredDamageFactor;
    function GetFrozenDurationTicks: LongInt;
    property FrozenDurationTicks: LongInt read GetFrozenDurationTicks;
    function GetHastenedDurationTicks: LongInt;
    property HastenedDurationTicks: LongInt read GetHastenedDurationTicks;
    function GetHastenedBonusDurationFactor: Double;
    property HastenedBonusDurationFactor: Double read GetHastenedBonusDurationFactor;
    function GetHastenedMovementBonusFactor: Double;
    property HastenedMovementBonusFactor: Double read GetHastenedMovementBonusFactor;
    function GetHastenedRotationBonusFactor: Double;
    property HastenedRotationBonusFactor: Double read GetHastenedRotationBonusFactor;
    function GetShieldedDurationTicks: LongInt;
    property ShieldedDurationTicks: LongInt read GetShieldedDurationTicks;
    function GetShieldedBonusDurationFactor: Double;
    property ShieldedBonusDurationFactor: Double read GetShieldedBonusDurationFactor;
    function GetShieldedDirectDamageAbsorptionFactor: Double;
    property ShieldedDirectDamageAbsorptionFactor: Double read GetShieldedDirectDamageAbsorptionFactor;
    function GetAuraSkillRange: Double;
    property AuraSkillRange: Double read GetAuraSkillRange;
    function GetRangeBonusPerSkillLevel: Double;
    property RangeBonusPerSkillLevel: Double read GetRangeBonusPerSkillLevel;
    function GetMagicalDamageBonusPerSkillLevel: LongInt;
    property MagicalDamageBonusPerSkillLevel: LongInt read GetMagicalDamageBonusPerSkillLevel;
    function GetStaffDamageBonusPerSkillLevel: LongInt;
    property StaffDamageBonusPerSkillLevel: LongInt read GetStaffDamageBonusPerSkillLevel;
    function GetMovementBonusFactorPerSkillLevel: Double;
    property MovementBonusFactorPerSkillLevel: Double read GetMovementBonusFactorPerSkillLevel;
    function GetMagicalDamageAbsorptionPerSkillLevel: LongInt;
    property MagicalDamageAbsorptionPerSkillLevel: LongInt read GetMagicalDamageAbsorptionPerSkillLevel;

    destructor Destroy; override;

  end;

  TGameArray = array of TGame;

implementation

constructor TGame.Create(const randomSeed: Int64; const tickCount: LongInt; const mapSize: Double;
  const skillsEnabled: Boolean; const rawMessagesEnabled: Boolean; const friendlyFireDamageFactor: Double;
  const buildingDamageScoreFactor: Double; const buildingEliminationScoreFactor: Double;
  const minionDamageScoreFactor: Double; const minionEliminationScoreFactor: Double;
  const wizardDamageScoreFactor: Double; const wizardEliminationScoreFactor: Double;
  const teamWorkingScoreFactor: Double; const victoryScore: LongInt; const scoreGainRange: Double;
  const rawMessageMaxLength: LongInt; const rawMessageTransmissionSpeed: Double; const wizardRadius: Double;
  const wizardCastRange: Double; const wizardVisionRange: Double; const wizardForwardSpeed: Double;
  const wizardBackwardSpeed: Double; const wizardStrafeSpeed: Double; const wizardBaseLife: LongInt;
  const wizardLifeGrowthPerLevel: LongInt; const wizardBaseMana: LongInt; const wizardManaGrowthPerLevel: LongInt;
  const wizardBaseLifeRegeneration: Double; const wizardLifeRegenerationGrowthPerLevel: Double;
  const wizardBaseManaRegeneration: Double; const wizardManaRegenerationGrowthPerLevel: Double;
  const wizardMaxTurnAngle: Double; const wizardMaxResurrectionDelayTicks: LongInt;
  const wizardMinResurrectionDelayTicks: LongInt; const wizardActionCooldownTicks: LongInt;
  const staffCooldownTicks: LongInt; const magicMissileCooldownTicks: LongInt; const frostBoltCooldownTicks: LongInt;
  const fireballCooldownTicks: LongInt; const hasteCooldownTicks: LongInt; const shieldCooldownTicks: LongInt;
  const magicMissileManacost: LongInt; const frostBoltManacost: LongInt; const fireballManacost: LongInt;
  const hasteManacost: LongInt; const shieldManacost: LongInt; const staffDamage: LongInt; const staffSector: Double;
  const staffRange: Double; const levelUpXpValues: TLongIntArray; const minionRadius: Double;
  const minionVisionRange: Double; const minionSpeed: Double; const minionMaxTurnAngle: Double;
  const minionLife: LongInt; const factionMinionAppearanceIntervalTicks: LongInt;
  const orcWoodcutterActionCooldownTicks: LongInt; const orcWoodcutterDamage: LongInt;
  const orcWoodcutterAttackSector: Double; const orcWoodcutterAttackRange: Double;
  const fetishBlowdartActionCooldownTicks: LongInt; const fetishBlowdartAttackRange: Double;
  const fetishBlowdartAttackSector: Double; const bonusRadius: Double; const bonusAppearanceIntervalTicks: LongInt;
  const bonusScoreAmount: LongInt; const dartRadius: Double; const dartSpeed: Double; const dartDirectDamage: LongInt;
  const magicMissileRadius: Double; const magicMissileSpeed: Double; const magicMissileDirectDamage: LongInt;
  const frostBoltRadius: Double; const frostBoltSpeed: Double; const frostBoltDirectDamage: LongInt;
  const fireballRadius: Double; const fireballSpeed: Double; const fireballExplosionMaxDamageRange: Double;
  const fireballExplosionMinDamageRange: Double; const fireballExplosionMaxDamage: LongInt;
  const fireballExplosionMinDamage: LongInt; const guardianTowerRadius: Double; const guardianTowerVisionRange: Double;
  const guardianTowerLife: Double; const guardianTowerAttackRange: Double; const guardianTowerDamage: LongInt;
  const guardianTowerCooldownTicks: LongInt; const factionBaseRadius: Double; const factionBaseVisionRange: Double;
  const factionBaseLife: Double; const factionBaseAttackRange: Double; const factionBaseDamage: LongInt;
  const factionBaseCooldownTicks: LongInt; const burningDurationTicks: LongInt; const burningSummaryDamage: LongInt;
  const empoweredDurationTicks: LongInt; const empoweredDamageFactor: Double; const frozenDurationTicks: LongInt;
  const hastenedDurationTicks: LongInt; const hastenedBonusDurationFactor: Double;
  const hastenedMovementBonusFactor: Double; const hastenedRotationBonusFactor: Double;
  const shieldedDurationTicks: LongInt; const shieldedBonusDurationFactor: Double;
  const shieldedDirectDamageAbsorptionFactor: Double; const auraSkillRange: Double;
  const rangeBonusPerSkillLevel: Double; const magicalDamageBonusPerSkillLevel: LongInt;
  const staffDamageBonusPerSkillLevel: LongInt; const movementBonusFactorPerSkillLevel: Double;
  const magicalDamageAbsorptionPerSkillLevel: LongInt);
begin
  FRandomSeed := randomSeed;
  FTickCount := tickCount;
  FMapSize := mapSize;
  FSkillsEnabled := skillsEnabled;
  FRawMessagesEnabled := rawMessagesEnabled;
  FFriendlyFireDamageFactor := friendlyFireDamageFactor;
  FBuildingDamageScoreFactor := buildingDamageScoreFactor;
  FBuildingEliminationScoreFactor := buildingEliminationScoreFactor;
  FMinionDamageScoreFactor := minionDamageScoreFactor;
  FMinionEliminationScoreFactor := minionEliminationScoreFactor;
  FWizardDamageScoreFactor := wizardDamageScoreFactor;
  FWizardEliminationScoreFactor := wizardEliminationScoreFactor;
  FTeamWorkingScoreFactor := teamWorkingScoreFactor;
  FVictoryScore := victoryScore;
  FScoreGainRange := scoreGainRange;
  FRawMessageMaxLength := rawMessageMaxLength;
  FRawMessageTransmissionSpeed := rawMessageTransmissionSpeed;
  FWizardRadius := wizardRadius;
  FWizardCastRange := wizardCastRange;
  FWizardVisionRange := wizardVisionRange;
  FWizardForwardSpeed := wizardForwardSpeed;
  FWizardBackwardSpeed := wizardBackwardSpeed;
  FWizardStrafeSpeed := wizardStrafeSpeed;
  FWizardBaseLife := wizardBaseLife;
  FWizardLifeGrowthPerLevel := wizardLifeGrowthPerLevel;
  FWizardBaseMana := wizardBaseMana;
  FWizardManaGrowthPerLevel := wizardManaGrowthPerLevel;
  FWizardBaseLifeRegeneration := wizardBaseLifeRegeneration;
  FWizardLifeRegenerationGrowthPerLevel := wizardLifeRegenerationGrowthPerLevel;
  FWizardBaseManaRegeneration := wizardBaseManaRegeneration;
  FWizardManaRegenerationGrowthPerLevel := wizardManaRegenerationGrowthPerLevel;
  FWizardMaxTurnAngle := wizardMaxTurnAngle;
  FWizardMaxResurrectionDelayTicks := wizardMaxResurrectionDelayTicks;
  FWizardMinResurrectionDelayTicks := wizardMinResurrectionDelayTicks;
  FWizardActionCooldownTicks := wizardActionCooldownTicks;
  FStaffCooldownTicks := staffCooldownTicks;
  FMagicMissileCooldownTicks := magicMissileCooldownTicks;
  FFrostBoltCooldownTicks := frostBoltCooldownTicks;
  FFireballCooldownTicks := fireballCooldownTicks;
  FHasteCooldownTicks := hasteCooldownTicks;
  FShieldCooldownTicks := shieldCooldownTicks;
  FMagicMissileManacost := magicMissileManacost;
  FFrostBoltManacost := frostBoltManacost;
  FFireballManacost := fireballManacost;
  FHasteManacost := hasteManacost;
  FShieldManacost := shieldManacost;
  FStaffDamage := staffDamage;
  FStaffSector := staffSector;
  FStaffRange := staffRange;
  if Assigned(levelUpXpValues) then begin
    FLevelUpXpValues := Copy(levelUpXpValues, 0, Length(levelUpXpValues));
  end else begin
    FLevelUpXpValues := nil;
  end;
  FMinionRadius := minionRadius;
  FMinionVisionRange := minionVisionRange;
  FMinionSpeed := minionSpeed;
  FMinionMaxTurnAngle := minionMaxTurnAngle;
  FMinionLife := minionLife;
  FFactionMinionAppearanceIntervalTicks := factionMinionAppearanceIntervalTicks;
  FOrcWoodcutterActionCooldownTicks := orcWoodcutterActionCooldownTicks;
  FOrcWoodcutterDamage := orcWoodcutterDamage;
  FOrcWoodcutterAttackSector := orcWoodcutterAttackSector;
  FOrcWoodcutterAttackRange := orcWoodcutterAttackRange;
  FFetishBlowdartActionCooldownTicks := fetishBlowdartActionCooldownTicks;
  FFetishBlowdartAttackRange := fetishBlowdartAttackRange;
  FFetishBlowdartAttackSector := fetishBlowdartAttackSector;
  FBonusRadius := bonusRadius;
  FBonusAppearanceIntervalTicks := bonusAppearanceIntervalTicks;
  FBonusScoreAmount := bonusScoreAmount;
  FDartRadius := dartRadius;
  FDartSpeed := dartSpeed;
  FDartDirectDamage := dartDirectDamage;
  FMagicMissileRadius := magicMissileRadius;
  FMagicMissileSpeed := magicMissileSpeed;
  FMagicMissileDirectDamage := magicMissileDirectDamage;
  FFrostBoltRadius := frostBoltRadius;
  FFrostBoltSpeed := frostBoltSpeed;
  FFrostBoltDirectDamage := frostBoltDirectDamage;
  FFireballRadius := fireballRadius;
  FFireballSpeed := fireballSpeed;
  FFireballExplosionMaxDamageRange := fireballExplosionMaxDamageRange;
  FFireballExplosionMinDamageRange := fireballExplosionMinDamageRange;
  FFireballExplosionMaxDamage := fireballExplosionMaxDamage;
  FFireballExplosionMinDamage := fireballExplosionMinDamage;
  FGuardianTowerRadius := guardianTowerRadius;
  FGuardianTowerVisionRange := guardianTowerVisionRange;
  FGuardianTowerLife := guardianTowerLife;
  FGuardianTowerAttackRange := guardianTowerAttackRange;
  FGuardianTowerDamage := guardianTowerDamage;
  FGuardianTowerCooldownTicks := guardianTowerCooldownTicks;
  FFactionBaseRadius := factionBaseRadius;
  FFactionBaseVisionRange := factionBaseVisionRange;
  FFactionBaseLife := factionBaseLife;
  FFactionBaseAttackRange := factionBaseAttackRange;
  FFactionBaseDamage := factionBaseDamage;
  FFactionBaseCooldownTicks := factionBaseCooldownTicks;
  FBurningDurationTicks := burningDurationTicks;
  FBurningSummaryDamage := burningSummaryDamage;
  FEmpoweredDurationTicks := empoweredDurationTicks;
  FEmpoweredDamageFactor := empoweredDamageFactor;
  FFrozenDurationTicks := frozenDurationTicks;
  FHastenedDurationTicks := hastenedDurationTicks;
  FHastenedBonusDurationFactor := hastenedBonusDurationFactor;
  FHastenedMovementBonusFactor := hastenedMovementBonusFactor;
  FHastenedRotationBonusFactor := hastenedRotationBonusFactor;
  FShieldedDurationTicks := shieldedDurationTicks;
  FShieldedBonusDurationFactor := shieldedBonusDurationFactor;
  FShieldedDirectDamageAbsorptionFactor := shieldedDirectDamageAbsorptionFactor;
  FAuraSkillRange := auraSkillRange;
  FRangeBonusPerSkillLevel := rangeBonusPerSkillLevel;
  FMagicalDamageBonusPerSkillLevel := magicalDamageBonusPerSkillLevel;
  FStaffDamageBonusPerSkillLevel := staffDamageBonusPerSkillLevel;
  FMovementBonusFactorPerSkillLevel := movementBonusFactorPerSkillLevel;
  FMagicalDamageAbsorptionPerSkillLevel := magicalDamageAbsorptionPerSkillLevel;
end;

function TGame.GetRandomSeed: Int64;
begin
  result := FRandomSeed;
end;

function TGame.GetTickCount: LongInt;
begin
  result := FTickCount;
end;

function TGame.GetMapSize: Double;
begin
  result := FMapSize;
end;

function TGame.GetSkillsEnabled: Boolean;
begin
  result := FSkillsEnabled;
end;

function TGame.GetRawMessagesEnabled: Boolean;
begin
  result := FRawMessagesEnabled;
end;

function TGame.GetFriendlyFireDamageFactor: Double;
begin
  result := FFriendlyFireDamageFactor;
end;

function TGame.GetBuildingDamageScoreFactor: Double;
begin
  result := FBuildingDamageScoreFactor;
end;

function TGame.GetBuildingEliminationScoreFactor: Double;
begin
  result := FBuildingEliminationScoreFactor;
end;

function TGame.GetMinionDamageScoreFactor: Double;
begin
  result := FMinionDamageScoreFactor;
end;

function TGame.GetMinionEliminationScoreFactor: Double;
begin
  result := FMinionEliminationScoreFactor;
end;

function TGame.GetWizardDamageScoreFactor: Double;
begin
  result := FWizardDamageScoreFactor;
end;

function TGame.GetWizardEliminationScoreFactor: Double;
begin
  result := FWizardEliminationScoreFactor;
end;

function TGame.GetTeamWorkingScoreFactor: Double;
begin
  result := FTeamWorkingScoreFactor;
end;

function TGame.GetVictoryScore: LongInt;
begin
  result := FVictoryScore;
end;

function TGame.GetScoreGainRange: Double;
begin
  result := FScoreGainRange;
end;

function TGame.GetRawMessageMaxLength: LongInt;
begin
  result := FRawMessageMaxLength;
end;

function TGame.GetRawMessageTransmissionSpeed: Double;
begin
  result := FRawMessageTransmissionSpeed;
end;

function TGame.GetWizardRadius: Double;
begin
  result := FWizardRadius;
end;

function TGame.GetWizardCastRange: Double;
begin
  result := FWizardCastRange;
end;

function TGame.GetWizardVisionRange: Double;
begin
  result := FWizardVisionRange;
end;

function TGame.GetWizardForwardSpeed: Double;
begin
  result := FWizardForwardSpeed;
end;

function TGame.GetWizardBackwardSpeed: Double;
begin
  result := FWizardBackwardSpeed;
end;

function TGame.GetWizardStrafeSpeed: Double;
begin
  result := FWizardStrafeSpeed;
end;

function TGame.GetWizardBaseLife: LongInt;
begin
  result := FWizardBaseLife;
end;

function TGame.GetWizardLifeGrowthPerLevel: LongInt;
begin
  result := FWizardLifeGrowthPerLevel;
end;

function TGame.GetWizardBaseMana: LongInt;
begin
  result := FWizardBaseMana;
end;

function TGame.GetWizardManaGrowthPerLevel: LongInt;
begin
  result := FWizardManaGrowthPerLevel;
end;

function TGame.GetWizardBaseLifeRegeneration: Double;
begin
  result := FWizardBaseLifeRegeneration;
end;

function TGame.GetWizardLifeRegenerationGrowthPerLevel: Double;
begin
  result := FWizardLifeRegenerationGrowthPerLevel;
end;

function TGame.GetWizardBaseManaRegeneration: Double;
begin
  result := FWizardBaseManaRegeneration;
end;

function TGame.GetWizardManaRegenerationGrowthPerLevel: Double;
begin
  result := FWizardManaRegenerationGrowthPerLevel;
end;

function TGame.GetWizardMaxTurnAngle: Double;
begin
  result := FWizardMaxTurnAngle;
end;

function TGame.GetWizardMaxResurrectionDelayTicks: LongInt;
begin
  result := FWizardMaxResurrectionDelayTicks;
end;

function TGame.GetWizardMinResurrectionDelayTicks: LongInt;
begin
  result := FWizardMinResurrectionDelayTicks;
end;

function TGame.GetWizardActionCooldownTicks: LongInt;
begin
  result := FWizardActionCooldownTicks;
end;

function TGame.GetStaffCooldownTicks: LongInt;
begin
  result := FStaffCooldownTicks;
end;

function TGame.GetMagicMissileCooldownTicks: LongInt;
begin
  result := FMagicMissileCooldownTicks;
end;

function TGame.GetFrostBoltCooldownTicks: LongInt;
begin
  result := FFrostBoltCooldownTicks;
end;

function TGame.GetFireballCooldownTicks: LongInt;
begin
  result := FFireballCooldownTicks;
end;

function TGame.GetHasteCooldownTicks: LongInt;
begin
  result := FHasteCooldownTicks;
end;

function TGame.GetShieldCooldownTicks: LongInt;
begin
  result := FShieldCooldownTicks;
end;

function TGame.GetMagicMissileManacost: LongInt;
begin
  result := FMagicMissileManacost;
end;

function TGame.GetFrostBoltManacost: LongInt;
begin
  result := FFrostBoltManacost;
end;

function TGame.GetFireballManacost: LongInt;
begin
  result := FFireballManacost;
end;

function TGame.GetHasteManacost: LongInt;
begin
  result := FHasteManacost;
end;

function TGame.GetShieldManacost: LongInt;
begin
  result := FShieldManacost;
end;

function TGame.GetStaffDamage: LongInt;
begin
  result := FStaffDamage;
end;

function TGame.GetStaffSector: Double;
begin
  result := FStaffSector;
end;

function TGame.GetStaffRange: Double;
begin
  result := FStaffRange;
end;

function TGame.GetLevelUpXpValues: TLongIntArray;
begin
  if Assigned(FLevelUpXpValues) then begin
    result := Copy(FLevelUpXpValues, 0, Length(FLevelUpXpValues));
  end else begin
    result := nil;
  end;
end;

function TGame.GetMinionRadius: Double;
begin
  result := FMinionRadius;
end;

function TGame.GetMinionVisionRange: Double;
begin
  result := FMinionVisionRange;
end;

function TGame.GetMinionSpeed: Double;
begin
  result := FMinionSpeed;
end;

function TGame.GetMinionMaxTurnAngle: Double;
begin
  result := FMinionMaxTurnAngle;
end;

function TGame.GetMinionLife: LongInt;
begin
  result := FMinionLife;
end;

function TGame.GetFactionMinionAppearanceIntervalTicks: LongInt;
begin
  result := FFactionMinionAppearanceIntervalTicks;
end;

function TGame.GetOrcWoodcutterActionCooldownTicks: LongInt;
begin
  result := FOrcWoodcutterActionCooldownTicks;
end;

function TGame.GetOrcWoodcutterDamage: LongInt;
begin
  result := FOrcWoodcutterDamage;
end;

function TGame.GetOrcWoodcutterAttackSector: Double;
begin
  result := FOrcWoodcutterAttackSector;
end;

function TGame.GetOrcWoodcutterAttackRange: Double;
begin
  result := FOrcWoodcutterAttackRange;
end;

function TGame.GetFetishBlowdartActionCooldownTicks: LongInt;
begin
  result := FFetishBlowdartActionCooldownTicks;
end;

function TGame.GetFetishBlowdartAttackRange: Double;
begin
  result := FFetishBlowdartAttackRange;
end;

function TGame.GetFetishBlowdartAttackSector: Double;
begin
  result := FFetishBlowdartAttackSector;
end;

function TGame.GetBonusRadius: Double;
begin
  result := FBonusRadius;
end;

function TGame.GetBonusAppearanceIntervalTicks: LongInt;
begin
  result := FBonusAppearanceIntervalTicks;
end;

function TGame.GetBonusScoreAmount: LongInt;
begin
  result := FBonusScoreAmount;
end;

function TGame.GetDartRadius: Double;
begin
  result := FDartRadius;
end;

function TGame.GetDartSpeed: Double;
begin
  result := FDartSpeed;
end;

function TGame.GetDartDirectDamage: LongInt;
begin
  result := FDartDirectDamage;
end;

function TGame.GetMagicMissileRadius: Double;
begin
  result := FMagicMissileRadius;
end;

function TGame.GetMagicMissileSpeed: Double;
begin
  result := FMagicMissileSpeed;
end;

function TGame.GetMagicMissileDirectDamage: LongInt;
begin
  result := FMagicMissileDirectDamage;
end;

function TGame.GetFrostBoltRadius: Double;
begin
  result := FFrostBoltRadius;
end;

function TGame.GetFrostBoltSpeed: Double;
begin
  result := FFrostBoltSpeed;
end;

function TGame.GetFrostBoltDirectDamage: LongInt;
begin
  result := FFrostBoltDirectDamage;
end;

function TGame.GetFireballRadius: Double;
begin
  result := FFireballRadius;
end;

function TGame.GetFireballSpeed: Double;
begin
  result := FFireballSpeed;
end;

function TGame.GetFireballExplosionMaxDamageRange: Double;
begin
  result := FFireballExplosionMaxDamageRange;
end;

function TGame.GetFireballExplosionMinDamageRange: Double;
begin
  result := FFireballExplosionMinDamageRange;
end;

function TGame.GetFireballExplosionMaxDamage: LongInt;
begin
  result := FFireballExplosionMaxDamage;
end;

function TGame.GetFireballExplosionMinDamage: LongInt;
begin
  result := FFireballExplosionMinDamage;
end;

function TGame.GetGuardianTowerRadius: Double;
begin
  result := FGuardianTowerRadius;
end;

function TGame.GetGuardianTowerVisionRange: Double;
begin
  result := FGuardianTowerVisionRange;
end;

function TGame.GetGuardianTowerLife: Double;
begin
  result := FGuardianTowerLife;
end;

function TGame.GetGuardianTowerAttackRange: Double;
begin
  result := FGuardianTowerAttackRange;
end;

function TGame.GetGuardianTowerDamage: LongInt;
begin
  result := FGuardianTowerDamage;
end;

function TGame.GetGuardianTowerCooldownTicks: LongInt;
begin
  result := FGuardianTowerCooldownTicks;
end;

function TGame.GetFactionBaseRadius: Double;
begin
  result := FFactionBaseRadius;
end;

function TGame.GetFactionBaseVisionRange: Double;
begin
  result := FFactionBaseVisionRange;
end;

function TGame.GetFactionBaseLife: Double;
begin
  result := FFactionBaseLife;
end;

function TGame.GetFactionBaseAttackRange: Double;
begin
  result := FFactionBaseAttackRange;
end;

function TGame.GetFactionBaseDamage: LongInt;
begin
  result := FFactionBaseDamage;
end;

function TGame.GetFactionBaseCooldownTicks: LongInt;
begin
  result := FFactionBaseCooldownTicks;
end;

function TGame.GetBurningDurationTicks: LongInt;
begin
  result := FBurningDurationTicks;
end;

function TGame.GetBurningSummaryDamage: LongInt;
begin
  result := FBurningSummaryDamage;
end;

function TGame.GetEmpoweredDurationTicks: LongInt;
begin
  result := FEmpoweredDurationTicks;
end;

function TGame.GetEmpoweredDamageFactor: Double;
begin
  result := FEmpoweredDamageFactor;
end;

function TGame.GetFrozenDurationTicks: LongInt;
begin
  result := FFrozenDurationTicks;
end;

function TGame.GetHastenedDurationTicks: LongInt;
begin
  result := FHastenedDurationTicks;
end;

function TGame.GetHastenedBonusDurationFactor: Double;
begin
  result := FHastenedBonusDurationFactor;
end;

function TGame.GetHastenedMovementBonusFactor: Double;
begin
  result := FHastenedMovementBonusFactor;
end;

function TGame.GetHastenedRotationBonusFactor: Double;
begin
  result := FHastenedRotationBonusFactor;
end;

function TGame.GetShieldedDurationTicks: LongInt;
begin
  result := FShieldedDurationTicks;
end;

function TGame.GetShieldedBonusDurationFactor: Double;
begin
  result := FShieldedBonusDurationFactor;
end;

function TGame.GetShieldedDirectDamageAbsorptionFactor: Double;
begin
  result := FShieldedDirectDamageAbsorptionFactor;
end;

function TGame.GetAuraSkillRange: Double;
begin
  result := FAuraSkillRange;
end;

function TGame.GetRangeBonusPerSkillLevel: Double;
begin
  result := FRangeBonusPerSkillLevel;
end;

function TGame.GetMagicalDamageBonusPerSkillLevel: LongInt;
begin
  result := FMagicalDamageBonusPerSkillLevel;
end;

function TGame.GetStaffDamageBonusPerSkillLevel: LongInt;
begin
  result := FStaffDamageBonusPerSkillLevel;
end;

function TGame.GetMovementBonusFactorPerSkillLevel: Double;
begin
  result := FMovementBonusFactorPerSkillLevel;
end;

function TGame.GetMagicalDamageAbsorptionPerSkillLevel: LongInt;
begin
  result := FMagicalDamageAbsorptionPerSkillLevel;
end;

destructor TGame.Destroy;
begin
  inherited;
end;

end.
